#!/usr/bin/env python3
"""
Replace cmake-installed files with symlinks back to their source in the build/source tree.

Usage: install_links.py <build_dir> <source_dir>

For each file listed in <build_dir>/install_manifest.txt:
  - Search for a file with the same name in the build and source trees
  - If a match with identical content is found, replace the installed copy with a symlink
"""

import filecmp
import os
import sys


def build_index(search_dirs: list[str]) -> dict[str, list[str]]:
    """Map filename -> list of real-file paths found under search_dirs."""
    index: dict[str, list[str]] = {}
    skip_dirs = {"CMakeFiles", "_deps", ".git"}
    for d in search_dirs:
        if not os.path.isdir(d):
            continue
        for root, dirs, files in os.walk(d):
            dirs[:] = [x for x in dirs if x not in skip_dirs]
            for fname in files:
                path = os.path.join(root, fname)
                if not os.path.islink(path):
                    index.setdefault(fname, []).append(path)
    return index


def main() -> None:
    if len(sys.argv) != 3:
        print(f"Usage: {sys.argv[0]} <build_dir> <source_dir>", file=sys.stderr)
        sys.exit(1)

    build_dir, source_dir = sys.argv[1], sys.argv[2]
    manifest_path = os.path.join(build_dir, "install_manifest.txt")

    if not os.path.isfile(manifest_path):
        print(f"No install manifest found at {manifest_path}", file=sys.stderr)
        sys.exit(1)

    # Search for source files in the build tree and project include dir
    search_dirs = [build_dir, os.path.join(source_dir, "include")]
    index = build_index(search_dirs)

    with open(manifest_path) as f:
        installed = [line.strip() for line in f if line.strip()]

    n_linked = 0
    n_skipped = 0

    for dst in installed:
        # Skip entries that are already symlinks or don't exist as regular files
        if not os.path.isfile(dst) or os.path.islink(dst):
            continue

        fname = os.path.basename(dst)
        candidates = index.get(fname, [])

        matched = False
        for src in candidates:
            if filecmp.cmp(src, dst, shallow=False):
                real_src = os.path.realpath(src)
                os.remove(dst)
                os.symlink(real_src, dst)
                print(f"  linked  {dst}")
                print(f"       -> {real_src}")
                n_linked += 1
                matched = True
                break

        if not matched:
            n_skipped += 1

    print(f"\n{n_linked} files linked, {n_skipped} left as copies (generated or transformed).")


if __name__ == "__main__":
    main()

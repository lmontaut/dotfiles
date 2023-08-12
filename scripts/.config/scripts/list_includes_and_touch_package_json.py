import os
import argparse

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--path", dest="path", default="", type=str)
    args = parser.parse_args()

    path: str = args.path
    if path != "" and path is not None:
        if not path.count("include"):
            include_path = os.path.join(path, "include")
            include_dirs = os.listdir(include_path)
            for dir in include_dirs:
                dir_path = os.path.join(include_path, dir)
                if os.path.isdir(dir_path):
                    new_file_path = os.path.join(dir_path, "package.json")
                    open(new_file_path, 'w').close()


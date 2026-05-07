#!/bin/zsh

APP="rerun"
FALLBACK_EXE="$HOME/anaconda3/lib/python3.10/site-packages/rerun_sdk/rerun_cli/rerun"

if pgrep -x "$APP" >/dev/null; then
  osascript <<APPLESCRIPT
tell application "System Events"
  tell process "$APP"
    set frontmost to true
    if exists window 1 then perform action "AXRaise" of window 1
  end tell
end tell
APPLESCRIPT
else
  open "$FALLBACK_EXE"
fi

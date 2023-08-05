#!/usr/bin/env bash

run () {
  local script=$1

  echo "✅ [$script] started"

  "$script"

  if [ $? -eq 0 ] ; then
    echo "✅ [$script] completed"
  else
    echo "❗ [$script] failed"
    exit 1
  fi
}

PLATFORM=$(uname)
echo "✅ Platform Detected: $PLATFORM"
if [ $PLATFORM == "Linux" ]; then
elif [ $PLATFORM == "Darwin" ]; then
  run "macos/setup-zsh.sh"
  run "macos/setup-brew.sh"
  run "macos/setup-asdf.sh"
  run "macos/setup-git.sh"
else
  echo "❌ Current platform not allowed!"
  exit 1
fi

echo "🎉 Completed! 🎉"

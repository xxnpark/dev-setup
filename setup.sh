#!/usr/bin/env bash

abort () {
  echo "$@"
  exit 1
}

run () {
  local script=$1

  echo "✅ [$script] started"

  "$script"

  if [ $? -eq 0 ] ; then
    echo "✅ [$script] completed"
  else
    abort "❗ [$script] failed"
  fi
}

PLATFORM=$(uname)
echo "✅ Platform Detected: $PLATFORM"
if [ $PLATFORM == "Linux" ]; then
elif [ $PLATFORM == "Darwin" ]; then
  run "macos/setup-zsh.sh"
  run "macos/setup-brew.sh"
  run "macos/setup-vim.sh"
  run "macos/setup-asdf.sh"
  run "macos/setup-git.sh"
else
  abort "❌ Current platform not allowed!"
fi

echo "🎉 Completed! 🎉"

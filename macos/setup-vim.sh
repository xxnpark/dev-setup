#!/usr/bin/env bash
set -eu

abort () {
  echo "$@"
  exit 1
}

if type nvim &>/dev/null; then
  echo "[vim] Neovim found at $(which nvim)"
else
  abort "[vim] Neovim not found!"
fi

ZSHRC_PATH="$HOME/.zshrc"
echo "[vim] setting environment variable EDITOR to nvim in zshrc at $ZSHRC_PATH"
cat <<EOF >> "$ZSHRC_PATH"

# nvim
export EDITOR='nvim'
EOF

SPACEVIM_PATH="$HOME/.SpaceVim"
if [[ -d "$SPACEVIM_PATH" ]]; then
  echo "[vim] SpaceVim found at $SPACEVIM_PATH"
else
  echo "[vim] install SpaceVim"
  curl -sLf https://spacevim.org/install.sh | bash
fi

echo "[vim] configure SpaceVim settings"
cat <<EOF > "$HOME/.SpaceVim.d/init.toml"
# All SpaceVim options are below [options] snippet
[options]
    colorscheme = "dracula"
    colorscheme_bg = "dark"
    enable_guicolors = true
    statusline_separator = "arrow"
    statusline_iseparator = "arrow"
    buffer_index_type = 4
    enable_tabline_filetype_icon = true
    enable_statusline_mode = false

# Enable autocomplete layer
[[layers]]
  name = 'autocomplete'
  auto_completion_return_key_behavior = "complete"
  auto_completion_tab_key_behavior = "smart"

[[layers]]
  name = 'shell'
  default_position = 'top'
  default_height = 30

[[layers]]
  name = 'git'

[[layers]]
  name = 'github'

[[layers]]
  name = 'shell'

[[layers]]
  name = 'ssh'

[[layers]]
  name = 'sudo'

[[Layers]]
  name = 'test'

[[Layers]]
  name = 'ui'

# Language Layers
[[Layers]]
  name = 'lang#dockerfile'

[[layers]]
  name = 'lang#html'

[[layers]]
  name = 'lang#java'

[[layers]]
  name = 'lang#javascript'

[[layers]]
  name = 'lang#json'

[[layers]]
  name = 'lang#kotlin'

[[layers]]
  name = 'lang#latex'

[[layers]]
  name = 'lang#markdown'

[[layers]]
  name = 'lang#python'

[[layers]]
  name = 'lang#ruby'

[[layers]]
  name = 'lang#typescript'

[[custom_plugins]]
  repo = 'dracula/vim'
  name = 'dracula'
  merged = false
EOF

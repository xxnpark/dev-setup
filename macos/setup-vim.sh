#!/usr/bin/env bash
set -eu

echo "[vim] set EDITOR env to nvim"
cat <<EOF >> "$HOME/.zshrc"

# nvim
export EDITOR='nvim'
EOF

echo "[vim] install spacevim"
curl -sLf https://spacevim.org/install.sh | bash

echo "[vim] configure spacevim settings"
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

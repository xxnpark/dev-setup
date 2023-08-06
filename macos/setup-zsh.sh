#!/usr/bin/env bash
set -eu

if type zinit &>/dev/null; then
  echo "[zsh] zinit found: $(which zinit)"
  if [ -d "${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git" ]; then
    echo "[zsh] zinit not installed correctly!"
    exit 1
  fi
else
  echo "[zsh] installing zinit"
  bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
  # zinit self-update
fi

ZSHRC_PATH="$HOME/.zshrc"

echo "[zsh] adding zinit plugins"
cat <<EOF >> "$ZSHRC_PATH"

# Zinit Plugins
zinit light xxnpark/dracula-zsh
zinit light xxnpark/cgitc
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light simnalamburt/zsh-expand-all

# git
alias git_current_branch='git rev-parse --abbrev-ref HEAD'
EOF

echo "[zsh] setting prompt colors"
cat <<'EOF' >> "$ZSHRC_PATH"

# Prompt Context
prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
  fi
}
EOF

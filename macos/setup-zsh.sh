#!/usr/bin/env bash
set -eu

abort () {
  echo "$@"
  exit 1
}

if type zinit &>/dev/null; then
  echo "[zsh] zinit found at $(which zinit)"
  if [[ ! -d "${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git" ]]; then
    abort "[zsh] zinit not installed correctly!"
  fi
else
  echo "[zsh] installing zinit"
  bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
  # zinit self-update
fi

ZSHRC_PATH="$HOME/.zshrc"

echo "[zsh] adding zinit plugins to zshrc at $ZSHRC_PATH"
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

echo "[zsh] setting prompt colors in zshrc at $ZSHRC_PATH"
cat <<'EOF' >> "$ZSHRC_PATH"

# Prompt Context
prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
  fi
}
EOF

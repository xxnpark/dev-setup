#!/usr/bin/env bash
set -eu

if type brew &>/dev/null; then
  echo "[brew] found at path $(which brew)"
  if [[ -z "${HOMEBREW_PREFIX:-}" ]]; then
    echo "[brew] \$HOMEBREW_PREFIX is missing; broken homebrew found!"
    exit 1
  fi
else
  echo "[brew] installing"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [[ -f /opt/homebrew/bin/brew ]]; then
    HOMEBREW_PREFIX=$(/opt/homebrew/bin/brew --prefix)
  elif [[ -d /usr/local/bin/brew ]]; then
    HOMEBREW_PREFIX=$(/usr/local/bin/brew --prefix)
  else
    echo "[brew] could not find brew!"
    exit 1
  fi

  ZPROFILE_PATH="$HOME/.zprofile"
  echo "[brew] adding brew config to zprofile at $ZPROFILE_PATH"
  echo "\neval \"\$($HOMEBREW_PREFIX/bin/brew shellenv)\"" >> "$ZPROFILE_PATH"
  eval "$("${HOMEBREW_PREFIX}"/bin/brew shellenv)"
fi

echo "[brew] installing formulas"
brew install \
  awscli \
  colordiff \
  coreutils \
  curl \
  docker-buildx \
  gawk \
  gettext \
  gh \
  git \
  gmp \
  gnupg \
  jq \
  kube-linter \
  libyaml \
  mysql \
  neofetch \
  neovim \
  readline \
  redis \
  shellcheck \
  yq

echo "[brew] installing casks"
brew install --cask \
  docker \
  insomnia \
  openlens \
  rq \
  raycast \
  sequel-ace

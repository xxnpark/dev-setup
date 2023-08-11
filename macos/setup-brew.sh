#!/usr/bin/env bash
set -eu

abort () {
  echo "$@"
  exit 1
}

if type brew &>/dev/null; then
  echo "[brew] Homebrew found at $(which brew)"
  if [[ -z "${HOMEBREW_PREFIX:-}" ]]; then
    abort "[brew] \$HOMEBREW_PREFIX is missing; broken Homebrew found!"
  else
    echo "[brew] update Homebrew & upgrade already installed formulae"
    brew update
    brew upgrade
    brew cleanup
  fi
else
  echo "[brew] installing"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [[ -f /opt/homebrew/bin/brew ]]; then
    HOMEBREW_PREFIX=$(/opt/homebrew/bin/brew --prefix)
  elif [[ -d /usr/local/bin/brew ]]; then
    HOMEBREW_PREFIX=$(/usr/local/bin/brew --prefix)
  else
    abort "[brew] Homebrew not found!"
  fi

  ZPROFILE_PATH="$HOME/.zprofile"
  echo "[brew] adding brew config to zprofile at $ZPROFILE_PATH"
  echo "\neval \"\$($HOMEBREW_PREFIX/bin/brew shellenv)\"" >> "$ZPROFILE_PATH"
  eval "$("${HOMEBREW_PREFIX}"/bin/brew shellenv)"
fi

echo "[brew] installing formulae"
brew install \
  awscli \
  docker-buildx \
  gh \
  git \
  git-lfs \
  htop \
  jq \
  kube-linter \
  libyaml \
  neofetch \
  neovim \
  tree \
  yq

echo "[brew] installing gnu related formulas"
brew install \
  coreutils \
  diffutils \
  ed \
  findutils \
  gawk \
  gettext \
  gmp \
  gnupg \
  gnutils \
  gnu-getopt \
  gnu-indent \
  gnu-tar \
  gnu-sed \
  gnu-which \
  grep \
  gzip \
  wget

echo "[brew] installing casks"
brew install cask
brew install --cask \
  1password \
  authy \
  docker \
  firefox \
  google-chrome \
  google-cloud-sdk \
  iterm2 \
  jetbrains-toolbox \
  mactex \
  notion \
  openlens \
  postman \
  raycast \
  sequel-ace \
  slack \
  typora \
  visual-studio-code

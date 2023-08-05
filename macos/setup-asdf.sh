#!/usr/bin/env bash
set -eu

ASDF_DATA_DIR="$HOME/.asdf"
ASDF_PATH="$ASDF_DATA_DIR/bin/asdf"

if [ -d "$ASDF_DATA_DIR" ]; then
  echo "[asdf] found; updating"
  "$ASDF_PATH" update
else
  echo "[asdf] installing"
  git clone https://github.com/asdf-vm/asdf.git "$ASDF_DATA_DIR" --branch v0.12.0

  ZSHRC_PATH="$HOME/.zshrc"
  echo "[asdf] adding asdf config to zshrc at $ZSHRC_PATH"
  cat <<'EOF' >> "$HOME/.zshrc"

# asdf

. "$HOME/.asdf/asdf.sh"
EOF
fi

asdf_plugin_add () {
  local name=$1
  if "$ASDF_PATH" plugin list | grep -Fx "$name" > /dev/null; then
    echo "[asdf] plugin $name is already installed"
  else
    echo "[asdf] installing plugin $name"
    if [ $name == "java" ]; then
      "$ASDF_PATH" plugin add java https://github.com/halcyon/asdf-java.git

      ZSHRC_PATH="$HOME/.zshrc"
      echo "[asdf] adding java config to zshrc at $ZSHRC_PATH"
      cat <<'EOF' >> ZSHRC_PATH

# JAVA PATH
__asdf_java_path="$(asdf which java)"
if [[ -n "$__asdf_java_path" ]]; then
  export JAVA_HOME="$(dirname "$(dirname "$__asdf_java_path")")"
  export JDK_HOME="$JAVA_HOME"
fi
unset __asdf_java_path
EOF
    elif [ $name == "sops" ]; then
      "$ASDF_PATH" plugin add sops https://github.com/feniix/asdf-sops.git
    else
      "$ASDF_PATH" plugin add "$name"
    fi
  fi
}

asdf_plugin_add "helm-diff"
asdf_plugin_add "helm"
asdf_plugin_add "java"
asdf_plugin_add "kotlin"
asdf_plugin_add "kubectl"
asdf_plugin_add "kubectx"
asdf_plugin_add "kustomize"
asdf_plugin_add "nodejs"
asdf_plugin_add "poetry"
asdf_plugin_add "python"
asdf_plugin_add "ruby"
asdf_plugin_add "sops"
asdf_plugin_add "terraform"
asdf_plugin_add "tflint"
asdf_plugin_add "yarn"

cat <<EOF > "$HOME/.tool-versions"
helm-diff 3.8.1
helm 3.12.1
java openjdk-20.0.2
kotlin 1.8.22
kubectl 1.27.3
kubectx 0.9.4
kustomize 5.0.3
nodejs 18.16.0
poetry 1.5.0
python 3.11.3
ruby 3.2.2
sops 3.7.3
terraform 1.4.6
tflint 0.46.1
yarn 1.22.19
EOF

echo "[asdf] installing all plugins"
"$ASDF_PATH" install

echo "[asdf] upgrading all plugins"
"$ASDF_PATH" plugin update --all

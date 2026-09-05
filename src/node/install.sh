#!/usr/bin/env bash
set -e

if [ ! -f /usr/local/share/nvm/nvm.sh ]; then
    echo "[node] ERROR: nvm must run first." >&2
    exit 1
fi

export NVM_DIR=/usr/local/share/nvm
. "$NVM_DIR/nvm.sh"

NODE_VERSION="${VERSION:-lts}"
if [ "$NODE_VERSION" = "lts" ]; then
    nvm install --lts >/dev/null
else
    nvm install "$NODE_VERSION" >/dev/null
fi

INSTALLED_NODE_VERSION=$(node --version)
nvm alias default "$INSTALLED_NODE_VERSION" >/dev/null

NODE_BIN_DIR="$NVM_DIR/versions/node/$INSTALLED_NODE_VERSION/bin"
for NAME in node npm npx corepack; do
    if [ -x "$NODE_BIN_DIR/$NAME" ]; then
        ln -sf "$NODE_BIN_DIR/$NAME" "/usr/local/bin/$NAME"
    fi
done

echo "[node] installed: node $(node --version), npm $(npm --version)"
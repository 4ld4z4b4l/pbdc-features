#!/usr/bin/env bash
set -e

test -L /usr/local/bin/node
test -L /usr/local/bin/npm
test -x /usr/local/bin/node
NODE_BIN=$(readlink -f /usr/local/bin/node)
test -x "$NODE_BIN"
[ "$(stat -c %a "$NODE_BIN")" = "755" ]
case "$NODE_BIN" in
    /usr/local/share/nvm/versions/node/*) ;;
    *) exit 1 ;;
esac
node --version >/dev/null
npm --version >/dev/null

echo "[node] test passed: node $(node --version), npm $(npm --version)."
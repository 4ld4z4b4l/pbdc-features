#!/usr/bin/env bash
set -e

command -v dotagents >/dev/null
NODE_BIN=$(readlink -f "$(command -v node)")
test -x "$NODE_BIN"
node --version | grep -Eq '^v(20|[2-9][0-9])\.'
npm --version >/dev/null
dotagents --version >/dev/null 2>&1 || dotagents --help >/dev/null 2>&1

echo "[dotagents] test passed: $(dotagents --version 2>&1 | head -n 1)"
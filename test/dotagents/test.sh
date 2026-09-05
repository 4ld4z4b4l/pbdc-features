#!/usr/bin/env bash
set -e

command -v dotagents >/dev/null
node --version | grep -Eq '^v(20|[2-9][0-9])\.'
npm --version >/dev/null
git --version >/dev/null
dotagents --help >/dev/null 2>&1 || true

echo "[dotagents] test passed: $(dotagents --version 2>&1 | head -n 1)"
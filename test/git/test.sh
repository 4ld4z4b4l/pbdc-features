#!/usr/bin/env bash
set -e

test -x "$(command -v git)"
git --version >/dev/null

echo "[git] test passed."
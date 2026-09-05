#!/usr/bin/env bash
set -e

test -x "$(command -v podman)"
podman --version >/dev/null

echo "[podman] test passed."
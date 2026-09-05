#!/usr/bin/env bash
set -e

test -d /root/.poop
test -x "$(command -v podman)"
[ "$CONTAINER_HOST" = "unix:///root/.poop/poop" ]

echo "[poop] test passed."
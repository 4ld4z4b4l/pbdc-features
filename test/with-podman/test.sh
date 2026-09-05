#!/usr/bin/env bash
set -e

test -x /usr/local/bin/podman-mode
[ "$(podman-mode poop sh -c 'printf "%s" "$CONTAINER_HOST"')" = "unix:///root/.poop/poop" ]
[ "$(podman-mode pip sh -c 'printf "%s" "${CONTAINER_HOST:-unset}"')" = "unset" ]
podman-mode | grep -Eq 'mode: (pip|poop)'

echo "[with-podman] test passed."
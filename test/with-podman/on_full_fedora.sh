#!/usr/bin/env bash

source dev-container-features-test-lib

check "podman-mode installed" test -x /usr/local/bin/podman-mode
check "poop mode env" [ "$(podman-mode poop sh -c 'printf "%s" "$CONTAINER_HOST"')" = "unix:///root/.poop/poop" ]
check "pip mode clears env" [ "$(podman-mode pip sh -c 'printf "%s" "${CONTAINER_HOST:-unset}"')" = "unset" ]

reportResults
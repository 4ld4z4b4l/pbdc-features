#!/usr/bin/env bash

source dev-container-features-test-lib

check "poop dir" test -d /root/.poop
check "podman installed" command -v podman
check "CONTAINER_HOST env" [ "$CONTAINER_HOST" = "unix:///root/.poop/poop" ]

reportResults
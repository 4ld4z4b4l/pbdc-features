#!/usr/bin/env bash

source dev-container-features-test-lib

check "docker shim installed" test -x /usr/local/bin/docker
check "shim runs podman" docker -v 2>/dev/null | grep -q podman
check "buildx refused" sh -c '! docker buildx version >/dev/null 2>&1'
check "podman installed" command -v podman

reportResults
#!/usr/bin/env bash

source dev-container-features-test-lib

check "with-base marker" test -f /usr/local/share/pbdc-features/with-base
check "podman installed" command -v podman
check "podman runs" podman --version

reportResults
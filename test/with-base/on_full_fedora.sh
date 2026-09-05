#!/usr/bin/env bash

source dev-container-features-test-lib

check "with-base marker" test -f /usr/local/share/pbdc-features/with-base
check "dnf present" command -v dnf

reportResults
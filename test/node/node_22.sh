#!/usr/bin/env bash

source dev-container-features-test-lib

check "node v22" bash -c "node --version | grep -Eq '^v22\.'"
check "node symlink" test -L /usr/local/bin/node
check "npm runs" npm --version

reportResults
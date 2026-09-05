#!/usr/bin/env bash

source dev-container-features-test-lib

check "node v22" bash -c "node --version | grep -Eq '^v22\.'"
check "dotagents installed" command -v dotagents
check "dotagents runs" bash -c "dotagents --version >/dev/null 2>&1 || dotagents --help >/dev/null 2>&1"

reportResults
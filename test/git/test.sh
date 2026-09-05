#!/usr/bin/env bash

source dev-container-features-test-lib

check "git installed" command -v git
check "git runs" git --version

reportResults
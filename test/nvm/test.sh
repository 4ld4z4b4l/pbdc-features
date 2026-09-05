#!/usr/bin/env bash

source dev-container-features-test-lib

check "nvm.sh exists" test -s /usr/local/share/nvm/nvm.sh
check "profile snippet" test -f /etc/profile.d/pbdc-nvm.sh
check "NVM_DIR in profile" grep -q 'NVM_DIR' /etc/profile.d/pbdc-nvm.sh
check "nvm dir world-readable" bash -c "stat -c '%a' /usr/local/share/nvm | grep -Eq '^7[0-9][0-9]\$'"
check "nvm runs" bash -c 'NVM_DIR=/usr/local/share/nvm . /usr/local/share/nvm/nvm.sh; nvm --version'

reportResults
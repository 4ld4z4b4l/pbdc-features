#!/usr/bin/env bash
set -e

test -s /usr/local/share/nvm/nvm.sh
test -f /etc/profile.d/pbdc-nvm.sh
grep -q 'NVM_DIR' /etc/profile.d/pbdc-nvm.sh
stat -c '%a' /usr/local/share/nvm | grep -Eq '^7[0-9][0-9]$'
NVM_DIR=/usr/local/share/nvm bash -c '. /usr/local/share/nvm/nvm.sh; nvm --version' >/dev/null

echo "[nvm] test passed."
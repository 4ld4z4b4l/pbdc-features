#!/usr/bin/env bash

source dev-container-features-test-lib

check "with-base marker" test -f /usr/local/share/pbdc-features/with-base
check "git" git --version
check "podman" podman --version
check "podman user exists" id podman
check "poop dir" test -d /root/.poop
check "poop socket present" test -S /root/.poop/poop
check "CONTAINER_HOST env" [ "$CONTAINER_HOST" = "unix:///root/.poop/poop" ]
check "nvm" bash -c 'NVM_DIR=/usr/local/share/nvm . /usr/local/share/nvm/nvm.sh; nvm --version'
check "node" node --version
check "npm" npm --version
check "dotagents" command -v dotagents
check "podman-mode installed" test -x /usr/local/bin/podman-mode
check "pip mode clears env" [ "$(podman-mode pip sh -c 'printf "%s" "${CONTAINER_HOST:-unset}"')" = "unset" ]
check "poop mode env" [ "$(podman-mode poop sh -c 'printf "%s" "$CONTAINER_HOST"')" = "unix:///root/.poop/poop" ]

reportResults
#!/usr/bin/env bash

source dev-container-features-test-lib

check "with-base marker" test -f /usr/local/share/pbdc-features/with-base

PKG_MANAGER=$(cat /usr/local/share/pbdc-features/with-base)
case "$PKG_MANAGER" in
    dnf) check "package manager 'dnf'" command -v dnf ;;
    microdnf) check "package manager 'microdnf'" command -v microdnf ;;
    *) check "package manager recognized" false ;;
esac

reportResults
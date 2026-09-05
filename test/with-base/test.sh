#!/usr/bin/env bash
set -e

test -f /usr/local/share/pbdc-features/with-base
PKG_MANAGER=$(cat /usr/local/share/pbdc-features/with-base)
case "$PKG_MANAGER" in
    dnf) command -v dnf >/dev/null ;;
    microdnf) command -v microdnf >/dev/null ;;
    *) exit 1 ;;
esac

echo "[with-base] test passed: package manager '$PKG_MANAGER'."
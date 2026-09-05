#!/usr/bin/env bash
set -e

if [ ! -f /usr/local/share/pbdc-features/with-base ]; then
    echo "[git] ERROR: with-base must run first." >&2
    exit 1
fi
PKG_MANAGER=$(cat /usr/local/share/pbdc-features/with-base)

case "$PKG_MANAGER" in
    dnf)
        dnf install -y git
        dnf clean all
        ;;
    microdnf)
        microdnf install -y git
        microdnf clean all
        ;;
    *)
        echo "[git] ERROR: unsupported package manager '$PKG_MANAGER'." >&2
        exit 1
        ;;
esac

echo "[git] installed: $(git --version)"
#!/usr/bin/env bash
set -e

if [ ! -f /usr/local/share/pbdc-features/with-base ]; then
    echo "[dotagents] ERROR: with-base must run first." >&2
    exit 1
fi
PKG_MANAGER=$(cat /usr/local/share/pbdc-features/with-base)

case "$PKG_MANAGER" in
    dnf)
        dnf install -y nodejs npm git
        dnf clean all
        ;;
    microdnf)
        microdnf install -y nodejs npm git
        microdnf clean all
        ;;
    *)
        echo "[dotagents] ERROR: unsupported package manager '$PKG_MANAGER'." >&2
        exit 1
        ;;
esac

NODE_MAJOR=$(node --version | sed 's/^v//' | cut -d. -f1)
if [ "$NODE_MAJOR" -lt 20 ]; then
    echo "[dotagents] ERROR: requires Node.js >= 20 (found $(node --version))." >&2
    exit 1
fi

npm install -g @sentry/dotagents

echo "[dotagents] installed: $(dotagents --version 2>&1 | head -n 1) at $(command -v dotagents)"
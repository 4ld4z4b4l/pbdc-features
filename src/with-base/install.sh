#!/usr/bin/env bash
set -e

if command -v dnf >/dev/null 2>&1; then
    PKG_MANAGER=dnf
elif command -v microdnf >/dev/null 2>&1; then
    PKG_MANAGER=microdnf
else
    echo "[with-base] ERROR: base image is not rpm-based; expected dnf or microdnf." >&2
    exit 1
fi

echo "[with-base] base image conformant: package manager '$PKG_MANAGER' detected."
install -d /usr/local/share/pbdc-features
echo "$PKG_MANAGER" > /usr/local/share/pbdc-features/with-base
#!/usr/bin/env bash
set -euo pipefail

if [ "$(id -u)" -ne 0 ]; then
    echo "[pinp-up] ERROR: must run as root." >&2
    exit 1
fi

ENGINE_UID="${PINP_ENGINE_UID:-1000}"
ENGINE_USER="$(getent passwd "$ENGINE_UID" | cut -d: -f1)"
ENGINE_HOME="${PINP_ENGINE_HOME:-/var/lib/pbdc-pinp/home}"
RUNTIME_DIR="/run/user/$ENGINE_UID"
SOCKET_DIR="$RUNTIME_DIR/podman"

if [ -z "$ENGINE_USER" ]; then
    echo "[pinp-up] ERROR: no passwd entry for uid $ENGINE_UID." >&2
    exit 1
fi

if [ ! -e /dev/fuse ]; then
    echo "[pinp-up] creating /dev/fuse"
    mknod /dev/fuse c 10 229 || true
fi

for FILE in /etc/subuid /etc/subgid; do
    if ! grep -q "^${ENGINE_USER}:" "$FILE"; then
        echo "${ENGINE_USER}:100000:65536" >> "$FILE"
    fi
done

mkdir -p "$SOCKET_DIR" "$ENGINE_HOME/.config" "$ENGINE_HOME/.local/share" \
    "$ENGINE_HOME/.local/share/containers/storage/tmp"
chown -R "${ENGINE_UID}:${ENGINE_UID}" "$ENGINE_HOME" "$RUNTIME_DIR"

if [ -z "${PINP_IMAGES+x}" ]; then
    PINP_IMAGES=(registry.fedoraproject.org/fedora-minimal:latest registry.fedoraproject.org/fedora:latest)
fi

for IMAGE in "${PINP_IMAGES[@]}"; do
    echo "[pinp-up] pre-pulling $IMAGE"
    if ! timeout 180 setpriv --reuid="$ENGINE_UID" --regid="$ENGINE_UID" --init-groups \
            env HOME="$ENGINE_HOME" XDG_RUNTIME_DIR="$RUNTIME_DIR" \
            XDG_CONFIG_HOME="$ENGINE_HOME/.config" XDG_DATA_HOME="$ENGINE_HOME/.local/share" \
            podman pull "$IMAGE" >/dev/null 2>&1; then
        echo "[pinp-up] WARNING: pre-pull failed for $IMAGE (continuing)"
        continue
    fi
    if [ "$(printf '%s' "$IMAGE" | tr -cd '/' | wc -c)" -eq 1 ]; then
        TAG="docker.io/${IMAGE}"
        echo "[pinp-up] mirror-tagging $IMAGE as $TAG"
        if ! setpriv --reuid="$ENGINE_UID" --regid="$ENGINE_UID" --init-groups \
                env HOME="$ENGINE_HOME" XDG_RUNTIME_DIR="$RUNTIME_DIR" \
                XDG_CONFIG_HOME="$ENGINE_HOME/.config" XDG_DATA_HOME="$ENGINE_HOME/.local/share" \
                podman tag "$IMAGE" "$TAG" >/dev/null 2>&1; then
            echo "[pinp-up] WARNING: mirror-tag failed for $TAG (continuing)"
        fi
    fi
done

echo "PINP_ENGINE_HOME=$ENGINE_HOME"
echo "PINP_ENGINE_UID=$ENGINE_UID"
echo "PINP_SOCKET=unix://$SOCKET_DIR/podman.sock"
echo "PINP_RUNTIME_DIR=$RUNTIME_DIR"
echo "PINP_SOCKET_DIR=$SOCKET_DIR"
echo "[pinp-up] ready (service not started)"
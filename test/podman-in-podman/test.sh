#!/usr/bin/env bash
set -e

id podman >/dev/null
grep -q '^podman:10000:5000$' /etc/subuid
grep -q '^podman:10000:5000$' /etc/subgid
grep -q 'mount_program = "/usr/bin/fuse-overlayfs"' /etc/containers/storage.conf
test -d /var/lib/shared/overlay-images
test -f /var/lib/shared/overlay-images/images.lock

echo "[podman-in-podman] test passed."
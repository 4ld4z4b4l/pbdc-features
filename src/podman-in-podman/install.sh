#!/usr/bin/env bash
set -e

if ! id podman >/dev/null 2>&1; then
    useradd -m -s /usr/bin/bash podman
fi

printf 'podman:10000:5000\n' > /etc/subuid
printf 'podman:10000:5000\n' > /etc/subgid

install -d -o podman -g podman /home/podman/.local/share/containers
install -d /var/lib/containers
install -d /var/lib/shared/overlay-images /var/lib/shared/overlay-layers /var/lib/shared/vfs-images /var/lib/shared/vfs-layers
touch /var/lib/shared/overlay-images/images.lock
touch /var/lib/shared/overlay-layers/layers.lock
touch /var/lib/shared/vfs-images/images.lock
touch /var/lib/shared/vfs-layers/layers.lock

install -d /etc/containers
cat > /etc/containers/storage.conf <<'EOF'
[storage]
driver = "overlay"

[storage.options.overlay]
mount_program = "/usr/bin/fuse-overlayfs"
mountopt = "nodev,fsync=0"
additionalimage_stores = ["/var/lib/shared"]
EOF

install -d /home/podman/.config/containers
chown -R podman:podman /home/podman/.config

echo "[podman-in-podman] configured user 'podman', subuid/subgid 10000:5000, overlay storage via fuse-overlayfs."
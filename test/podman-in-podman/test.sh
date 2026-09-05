#!/usr/bin/env bash

source dev-container-features-test-lib

check "podman user exists" id podman
check "subuid range" grep -q '^podman:10000:5000$' /etc/subuid
check "subgid range" grep -q '^podman:10000:5000$' /etc/subgid
check "fuse-overlayfs mount_program" grep -q 'mount_program = "/usr/bin/fuse-overlayfs"' /etc/containers/storage.conf
check "additional image stores" grep -q 'additionalimage_stores' /etc/containers/storage.conf
check "shared overlay-images dir" test -d /var/lib/shared/overlay-images
check "images.lock" test -f /var/lib/shared/overlay-images/images.lock

reportResults
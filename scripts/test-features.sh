#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

BASE_IMAGE="${BASE_IMAGE:-registry.fedoraproject.org/fedora-minimal:latest}"
: "${DOCKER_HOST:?DOCKER_HOST must point at a rootless podman socket (e.g. unix:///root/.poop/poop)}"

run_chain() {
    echo "=== $* ==="
    devcontainer features test -p . -f "$@" --base-image "$BASE_IMAGE"
}

run_chain with-base
run_chain git with-base
run_chain podman with-base
run_chain podman-in-podman podman with-base
run_chain poop podman with-base
run_chain with-podman podman-in-podman poop podman with-base
run_chain nvm with-base
run_chain node nvm with-base
run_chain dotagents node nvm with-base

echo "All feature tests passed."
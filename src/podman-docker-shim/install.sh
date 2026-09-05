#!/usr/bin/env bash
set -e

if [ ! -x /usr/bin/podman ]; then
    echo "[podman-shim] ERROR: podman must be installed first (dependsOn ./podman)." >&2
    exit 1
fi

cat >/usr/local/bin/docker <<'EOF'
#!/bin/sh
if [ "${1:-}" = "buildx" ]; then
    echo "docker: 'buildx' is not a docker command." >&2
    exit 1
fi
exec /usr/bin/podman "$@"
EOF
chmod 755 /usr/local/bin/docker

echo "[podman-shim] installed: $(docker -v 2>/dev/null)"
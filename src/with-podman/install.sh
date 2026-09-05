#!/usr/bin/env bash
set -e

install -d /usr/local/share/podman-modes

cat > /usr/local/share/podman-modes/pip.sh <<'EOF'
unset CONTAINER_HOST
EOF

cat > /usr/local/share/podman-modes/poop.sh <<'EOF'
export CONTAINER_HOST="unix:///root/.poop/poop"
EOF

cat > /usr/local/bin/podman-mode <<'EOF'
#!/usr/bin/env bash
set -e

if [ "$#" -eq 0 ]; then
    if [ -n "${CONTAINER_HOST:-}" ]; then
        echo "mode: poop ($CONTAINER_HOST)"
    else
        echo "mode: pip"
    fi
    exit 0
fi

mode="$1"
shift

case "$mode" in
    pip)
        mode_script=/usr/local/share/podman-modes/pip.sh
        ;;
    poop)
        mode_script=/usr/local/share/podman-modes/poop.sh
        ;;
    *)
        echo "usage: podman-mode [pip|poop] <command...>" >&2
        exit 1
        ;;
esac

. "$mode_script"
"$@"
EOF
chmod +x /usr/local/bin/podman-mode

echo "[with-podman] podman-mode launcher installed."
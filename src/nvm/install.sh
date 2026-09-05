#!/usr/bin/env bash
set -e

if [ ! -f /usr/local/share/pbdc-features/with-base ]; then
    echo "[nvm] ERROR: with-base must run first." >&2
    exit 1
fi
PKG_MANAGER=$(cat /usr/local/share/pbdc-features/with-base)

case "$PKG_MANAGER" in
    dnf)
        dnf install -y curl ca-certificates tar gzip xz
        dnf clean all
        ;;
    microdnf)
        microdnf install -y curl ca-certificates tar gzip xz
        microdnf clean all
        ;;
    *)
        echo "[nvm] ERROR: unsupported package manager '$PKG_MANAGER'." >&2
        exit 1
        ;;
esac

export NVM_DIR=/usr/local/share/nvm
install -d "$NVM_DIR"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | NVM_DIR="$NVM_DIR" bash
chmod 755 "$NVM_DIR"

cat > /etc/profile.d/pbdc-nvm.sh <<'EOF'
export NVM_DIR="/usr/local/share/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
EOF

if [ -f /etc/bashrc ]; then
    echo '[ -f /etc/profile.d/pbdc-nvm.sh ] && . /etc/profile.d/pbdc-nvm.sh' >> /etc/bashrc
fi

echo "[nvm] installed: $(NVM_DIR="$NVM_DIR" bash -c '. "$NVM_DIR/nvm.sh"; nvm --version')"
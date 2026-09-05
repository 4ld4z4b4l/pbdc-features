#!/usr/bin/env bash
set -e

command -v node >/dev/null 2>&1 || { echo "[dotagents] ERROR: node feature must run first." >&2; exit 1; }
command -v npm >/dev/null 2>&1 || { echo "[dotagents] ERROR: npm is missing; the node feature must provide it." >&2; exit 1; }

NODE_MAJOR=$(node --version | sed 's/^v//' | cut -d. -f1)
if [ "$NODE_MAJOR" -lt 20 ]; then
    echo "[dotagents] ERROR: requires Node.js >= 20 (found $(node --version))." >&2
    exit 1
fi

npm install -g @sentry/dotagents

echo "[dotagents] installed: $(dotagents --version 2>&1 | head -n 1) at $(command -v dotagents)"
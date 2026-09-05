#!/usr/bin/env bash
set -e

install -d -m 0755 /root/.poop

echo "[poop] host socket bind-mounted at /root/.poop/poop; CONTAINER_HOST=unix:///root/.poop/poop."
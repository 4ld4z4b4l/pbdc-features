#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

jq -e . devcontainer-feature.json >/dev/null
echo "ok   devcontainer-feature.json"

for FILE in src/*/devcontainer-feature.json; do
    jq -e . "$FILE" >/dev/null
    echo "ok   $FILE"
done

echo "All feature manifests parse as valid JSON."
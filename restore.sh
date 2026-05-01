#!/bin/bash
set -euo pipefail

if [ -z "${1:-}" ]; then
  echo "Usage: $0 <backup.tar.zst>"
  exit 1
fi

ARCHIVE="$1"

if [ ! -f "$ARCHIVE" ]; then
  echo "Archive not found: $ARCHIVE"
  exit 1
fi

echo "About to extract $ARCHIVE into \$HOME ($HOME)."
echo "Existing files at the same paths will be OVERWRITTEN."
read -r -p "Continue? [y/N] " reply
if [[ ! "$reply" =~ ^[Yy]$ ]]; then
  echo "Aborted."
  exit 1
fi

cd "$HOME"
tar --use-compress-program="zstd -d -T0" -xpf "$ARCHIVE"

echo
echo "==> Done. After this, run yarn install / uv sync / Lazy! sync etc. in"
echo "    each project to repopulate the dependencies that weren't in the archive."

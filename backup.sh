#!/bin/bash
set -euo pipefail

DEST="${1:-$HOME/home-backup-$(date +%Y-%m-%d).tar.zst}"

# Anything in this list is either regenerable (yarn install / uv sync /
# nvm install / Lazy sync will rebuild it) or pure runtime cache. The
# whole point is to avoid tar walking a million tiny node_modules files.
EXCLUDES=(
  # Caches and regenerable language toolchains
  --exclude=".cache"
  --exclude=".apache_beam"
  --exclude=".local/share/Trash"
  --exclude=".local/share/lazy.nvim"
  --exclude=".local/share/nvim/mason"
  --exclude=".local/share/pnpm/store"
  --exclude=".nvm"
  --exclude=".npm"
  --exclude=".yarn/cache"
  --exclude=".cargo/registry"
  --exclude=".cargo/git"
  --exclude=".rustup"
  --exclude=".gradle"
  --exclude=".m2/repository"
  --exclude="go/pkg"

  # The dotfiles repo itself — clone fresh from github
  --exclude=".vim"

  # Unity engine + editor data (and any nested Unity dirs)
  --exclude="Unity"

  # Minecraft (saves + jars + texture caches) — re-download on new install
  --exclude=".minecraft"

  # Project dependency + build directories (any depth)
  --exclude="node_modules"
  --exclude=".venv"
  --exclude="venv"
  --exclude=".direnv"
  --exclude="__pycache__"
  --exclude=".pytest_cache"
  --exclude=".mypy_cache"
  --exclude=".ruff_cache"
  --exclude=".tox"
  --exclude="target"
  --exclude=".next"
  --exclude=".nuxt"
  --exclude=".turbo"

  # ML training run output (PyTorch Lightning, Weights & Biases, MLflow)
  --exclude="lightning_logs"
  --exclude="wandb"
  --exclude="mlruns"

  # plex/the-brain — ~470GB of cached/queried data files under each model
  --exclude="pinky/models/*/data"

  # Electron app caches — covers Chrome, VSCode, Antigravity, and any other
  # app under .config/ built on Electron (they all share this layout).
  --exclude=".config/*/Cache"
  --exclude=".config/*/CachedData"
  --exclude=".config/*/CachedExtensionVSIXs"
  --exclude=".config/*/CachedProfilesData"
  --exclude=".config/*/Code Cache"
  --exclude=".config/*/GPUCache"
  --exclude=".config/*/ShaderCache"
  --exclude=".config/*/GrShaderCache"
  --exclude=".config/*/Crashpad"
  --exclude=".config/*/blob_storage"
  --exclude=".config/*/DawnGraphiteCache"
  --exclude=".config/*/DawnWebGPUCache"
  --exclude=".config/*/Service Worker"
  --exclude=".config/*/Shared Dictionary"

  # Chrome aggressive — state that re-syncs from cloud (when signed in) or
  # re-installs from the Web Store. Bookmarks/history/passwords still kept.
  --exclude=".config/google-chrome/*/IndexedDB"
  --exclude=".config/google-chrome/*/File System"
  --exclude=".config/google-chrome/*/Extensions"
  --exclude=".config/google-chrome/component_crx_cache"
  --exclude=".config/google-chrome/extensions_crx_cache"
  --exclude=".config/google-chrome/optimization_guide_model_store"

  # Firefox disk cache
  --exclude=".mozilla/firefox/*/cache2"

  # Claude Code runtime state (settings + CLAUDE.md come back via dotfiles)
  --exclude=".claude/cache"
  --exclude=".claude/file-history"
  --exclude=".claude/shell-snapshots"
  --exclude=".claude/session-env"
  --exclude=".claude/paste-cache"
  --exclude=".claude/downloads"
  --exclude=".claude/backups"
  --exclude=".claude/telemetry"
  --exclude=".claude/statsig"
  --exclude=".claude/stats-cache.json"

  # Git LFS objects (often huge media, re-fetched on first checkout)
  --exclude=".git/lfs/objects"

  # Junk
  --exclude=".DS_Store"
  --exclude="*.pyc"
  --exclude="*.swp"
)

echo "==> Backing up \$HOME to $DEST"
echo "    (skipping node_modules / .venv / .cache / browser disk cache / etc.)"
echo

cd "$HOME"
tar --use-compress-program="zstd -T0 -3" \
    "${EXCLUDES[@]}" \
    -cf "$DEST" \
    .

size=$(du -h "$DEST" | cut -f1)
echo
echo "==> Done. $size at $DEST"

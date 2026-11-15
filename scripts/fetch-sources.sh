#!/usr/bin/env bash
# Lấy mã Che779-Emulator (V1) và Che779-EmulatorV2 đúng commit đã ghim vào build/src-v1, build/src-v2.
# Dùng: scripts/fetch-sources.sh   (cần git và mạng)
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
mkdir -p "$ROOT/build"
get(){ # tên repo, file ghim, thư mục đích
  local ref; ref="$(tr -d '[:space:]' < "$ROOT/apps/linux/$2")"
  rm -rf "$3"; git clone --quiet "https://github.com/Kidtomboy/$1.git" "$3"; git -C "$3" checkout --quiet "$ref"
  echo "OK: $1 @ ${ref:0:8}"
}
get Che779-Emulator EMULATOR_V1_REF "$ROOT/build/src-v1"
get Che779-EmulatorV2 EMULATOR_V2_REF "$ROOT/build/src-v2"

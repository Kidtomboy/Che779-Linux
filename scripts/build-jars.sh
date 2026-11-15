#!/usr/bin/env bash
# Build 3 jar vào build/jars: Che779_Emulator.jar (V1), Che779_EmulatorV2.jar (V2), Che779_Remoter.jar (Remoter Linux).
# Cần JDK 8+ và đã chạy scripts/fetch-sources.sh. Biến SRC_V1 / SRC_V2 cho phép trỏ tới thư mục mã khác.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
V1="${SRC_V1:-$ROOT/build/src-v1}"; V2="${SRC_V2:-$ROOT/build/src-v2}"
OUT="$ROOT/build/jars"; mkdir -p "$OUT"
bash "$V1/.github/scripts/build-emulator.sh" | grep -v '^Picked up' || true
cp "$V1/apps/emulator/source/Che779_Emulator.jar" "$OUT/"
bash "$V2/.github/scripts/build-emulator-v2.sh" | grep -v '^Picked up' || true
cp "$V2/apps/emulator-v2/source/Che779_EmulatorV2.jar" "$OUT/"
( cd "$ROOT/apps/linux/remoter-linux" && bash ./build.sh | grep -v '^Picked up' || true )
cp "$ROOT/apps/linux/remoter-linux/Che779_Remoter.jar" "$OUT/"
ls -l "$OUT"

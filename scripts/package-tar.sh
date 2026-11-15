#!/usr/bin/env bash
# Tạo che779-<phiên bản>-linux.tar.gz (chạy ngay, không cần cài): ./che779 và ./che779-remoter.
# Dùng: scripts/package-tar.sh [thư-mục-jar] [thư-mục-ra]
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
JARS="${1:-$ROOT/build/jars}"; OUT="${2:-$ROOT/dist}"
VER="$(tr -d '[:space:]' < "$ROOT/VERSION")"; N="che779-$VER-linux"
for j in Che779_Emulator.jar Che779_EmulatorV2.jar Che779_Remoter.jar; do [ -f "$JARS/$j" ] || { echo "Thiếu $JARS/$j" >&2; exit 1; }; done
T="$(mktemp -d)"; trap 'rm -rf "$T"' EXIT
mkdir -p "$T/$N/lib" "$OUT"
cp "$JARS"/Che779_*.jar "$T/$N/lib/"
for s in che779 che779-remoter; do sed "s/@VERSION@/$VER/" "$ROOT/apps/linux/packaging/$s" > "$T/$N/$s"; chmod +x "$T/$N/$s"; bash -n "$T/$N/$s"; done
cat > "$T/$N/DOC-TOI-DAY.txt" <<EOF
Che779 Linux $VER

1. Cần Java 8+ (Debian/Ubuntu/Mint: sudo apt install default-jre) và màn hình đồ họa.
2. ./che779            Emulator V2 (nhiều tab, một cửa sổ)   [-r MB để chọn RAM]
   ./che779-remoter    Emulator V1 + Remoter (mỗi tab một cửa sổ)
3. Game đặt ở ~/Che779Games (V2). Hướng dẫn: https://github.com/Kidtomboy/Che779-Linux
EOF
tar -C "$T" -czf "$OUT/$N.tar.gz" "$N"
echo "OK: $OUT/$N.tar.gz"

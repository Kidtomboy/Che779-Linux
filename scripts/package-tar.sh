#!/usr/bin/env bash
# Tạo che779-<v1|v2>-<phiên bản>-linux.tar.gz (chạy ngay, không cần cài): ./che779-v1 hoặc ./che779-v2.
# Dùng: scripts/package-tar.sh <v1|v2> [thư-mục-jar] [thư-mục-ra]
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
V="${1:?Dùng: package-tar.sh <v1|v2> [thư-mục-jar] [thư-mục-ra]}"
JARS="${2:-$ROOT/build/jars}"; OUT="${3:-$ROOT/dist}"
VER="$(tr -d '[:space:]' < "$ROOT/VERSION")"; N="che779-$V-$VER-linux"
case "$V" in v1) NEED="Che779_Emulator.jar Che779_Remoter.jar";; v2) NEED="Che779_EmulatorV2.jar";; *) echo "Chỉ nhận v1 hoặc v2" >&2; exit 2;; esac
for j in $NEED; do [ -f "$JARS/$j" ] || { echo "Thiếu $JARS/$j" >&2; exit 1; }; done
T="$(mktemp -d)"; trap 'rm -rf "$T"' EXIT
mkdir -p "$T/$N/lib" "$OUT"
for j in $NEED; do cp "$JARS/$j" "$T/$N/lib/"; done
sed "s/@VERSION@/$VER/" "$ROOT/apps/linux/packaging/che779-$V" > "$T/$N/che779-$V"; chmod +x "$T/$N/che779-$V"; bash -n "$T/$N/che779-$V"
if [ "$V" = v2 ]; then MO="./che779-v2   Emulator V2 (nhiều tab, một cửa sổ)   [-r MB để chọn RAM]
3. Game đặt ở ~/Che779Games."; else MO="./che779-v1   Emulator V1 + Remoter (mỗi tab một cửa sổ)
3. Game chọn trong cửa sổ Remoter."; fi
cat > "$T/$N/DOC-TOI-DAY.txt" <<EOT
Che779 Linux ${V^^} $VER

1. Cần Java 8+ (Debian/Ubuntu/Mint: sudo apt install default-jre) và màn hình đồ họa.
2. $MO
   Hướng dẫn: https://github.com/Kidtomboy/Che779-Linux
EOT
tar -C "$T" -czf "$OUT/$N.tar.gz" "$N"
echo "OK: $OUT/$N.tar.gz"

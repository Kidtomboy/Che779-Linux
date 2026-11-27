#!/usr/bin/env bash
# Ghép che779-linux.sh hoàn chỉnh = bản nguồn + jar Che779 EmulatorV2 nhúng (base64).
# Dùng:  scripts/build-release.sh <đường-dẫn-jar> [thư-mục-ra]
# Mã SHA-256 của jar được TÍNH TỪ CHÍNH FILE jar này rồi điền vào script — không ai dán tay.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
JAR="${1:?Thiếu đường dẫn jar. Dùng: build-release.sh <jar> [thư-mục-ra]}"
OUT="${2:-$ROOT/dist}"
[ -f "$JAR" ] || { echo "Không thấy jar: $JAR" >&2; exit 1; }
VER="$(tr -d '[:space:]' < "$ROOT/VERSION")"
SHA="$(sha256sum "$JAR" | cut -d' ' -f1)"
mkdir -p "$OUT"
sed -e "s/@VERSION@/$VER/" -e "s/@JAR_SHA256@/$SHA/" "$ROOT/apps/linux/che779-linux.sh" > "$OUT/che779-linux.sh"
base64 -w 76 "$JAR" >> "$OUT/che779-linux.sh"
chmod +x "$OUT/che779-linux.sh"
bash -n "$OUT/che779-linux.sh"
echo "OK: $OUT/che779-linux.sh  (phiên bản $VER, jar SHA-256 $SHA)"

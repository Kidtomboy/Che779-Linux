#!/usr/bin/env bash
# Ghép script Termux hoàn chỉnh = bản nguồn + jar nhúng (base64).
# Dùng:  apps/termux/build-termux.sh <v1|v2> <jar> <file-ra>
#   v2:  apps/termux/build-termux.sh v2 build/termux/Che779_EmulatorV2.jar dist/che779-termux-v2.sh
#   v1:  apps/termux/build-termux.sh v1 build/termux/Che779_Emulator.jar   dist/che779-termux-v1.sh
# Mã SHA-256 được TÍNH TỪ CHÍNH FILE jar rồi điền vào script — không ai dán tay.
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
V="${1:?Thiếu v1 hoặc v2}"; JAR="${2:?Thiếu jar}"; OUT="${3:?Thiếu file ra}"
case "$V" in v1) NAME=Che779_Emulator.jar;; v2) NAME=Che779_EmulatorV2.jar;; *) echo "Chỉ nhận v1 hoặc v2" >&2; exit 2;; esac
[ -f "$JAR" ] || { echo "Không thấy jar: $JAR" >&2; exit 1; }
VER="$(tr -d '[:space:]' < "$HERE/VERSION")"
SHA="$(sha256sum "$JAR" | cut -d' ' -f1)"
mkdir -p "$(dirname "$OUT")"
sed -e "s/@VERSION@/$VER/" -e "s/@JAR_SHA256@/$SHA/" -e "s/@JAR_NAME@/$NAME/g" -e "s/@VARIANT@/$V/" "$HERE/che779-termux.sh" > "$OUT"
base64 -w 76 "$JAR" >> "$OUT"
chmod +x "$OUT"
bash -n "$OUT"
echo "OK: $OUT  (phiên bản $VER, jar SHA-256 $SHA)"

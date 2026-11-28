#!/usr/bin/env bash
# Ghép che779-linux-v1.sh / che779-linux-v2.sh = bản nguồn + dữ liệu nhúng (base64).
#   v2: nhúng Che779_EmulatorV2.jar · v1: nhúng gói tar.gz gồm Che779_Emulator.jar + Che779_Remoter.jar.
# Dùng:  scripts/build-release.sh <v1|v2> <thư-mục-jar> [thư-mục-ra]   (mặc định jar: build/jars)
# Mã SHA-256 được TÍNH TỪ CHÍNH dữ liệu nhúng rồi điền vào script — không ai dán tay.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
V="${1:?Dùng: build-release.sh <v1|v2> <thư-mục-jar> [thư-mục-ra]}"
JARS="${2:-$ROOT/build/jars}"; OUT="${3:-$ROOT/dist}"
VER="$(tr -d '[:space:]' < "$ROOT/VERSION")"
T="$(mktemp -d)"; trap 'rm -rf "$T"' EXIT
case "$V" in
  v2) [ -f "$JARS/Che779_EmulatorV2.jar" ] || { echo "Thiếu $JARS/Che779_EmulatorV2.jar" >&2; exit 1; }
      PAY="$JARS/Che779_EmulatorV2.jar";;
  v1) for j in Che779_Emulator.jar Che779_Remoter.jar; do [ -f "$JARS/$j" ] || { echo "Thiếu $JARS/$j" >&2; exit 1; }; done
      PAY="$T/v1.tar.gz"; tar -C "$JARS" --owner=0 --group=0 -czf "$PAY" Che779_Emulator.jar Che779_Remoter.jar;;
  *) echo "Chỉ nhận v1 hoặc v2" >&2; exit 2;;
esac
SHA="$(sha256sum "$PAY" | cut -d' ' -f1)"
mkdir -p "$OUT"; F="$OUT/che779-linux-$V.sh"
sed -e "s/@VERSION@/$VER/" -e "s/@JAR_SHA256@/$SHA/" -e "s/@VARIANT@/$V/" "$ROOT/apps/linux/che779-linux.sh" > "$F"
base64 -w 76 "$PAY" >> "$F"
chmod +x "$F"; bash -n "$F"
echo "OK: $F  (phiên bản $VER, SHA-256 dữ liệu nhúng $SHA)"

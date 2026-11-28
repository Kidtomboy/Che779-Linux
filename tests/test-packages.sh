#!/usr/bin/env bash
# Kiểm thử gói v1 và v2: .tar.gz và .deb có đủ jar + lệnh, đúng phiên bản, lệnh chạy được (--version).
# Dùng: tests/test-packages.sh [thư-mục-jar]   (mặc định build/jars)
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
JARS="${1:-$ROOT/build/jars}"
T="$(mktemp -d)"; trap 'rm -rf "$T"' EXIT
fail(){ echo "THẤT BẠI: $*" >&2; exit 1; }
VER="$(tr -d '[:space:]' < "$ROOT/VERSION")"
for V in v1 v2; do
  bash "$ROOT/scripts/package-tar.sh" "$V" "$JARS" "$T/out" >/dev/null
  TAR="$T/out/che779-$V-$VER-linux.tar.gz"; [ -f "$TAR" ] || fail "thiếu tar $V"
  if [ "$V" = v1 ]; then JL="Che779_Emulator.jar Che779_Remoter.jar"; WANT="Che779 Emulator V1 + Remoter $VER (Linux)"; NOT=Che779_EmulatorV2.jar
  else JL="Che779_EmulatorV2.jar"; WANT="Che779 EmulatorV2 $VER (Linux)"; NOT=Che779_Remoter.jar; fi
  L="$(tar tzf "$TAR")"
  for f in che779-$V DOC-TOI-DAY.txt $(for j in $JL; do echo lib/$j; done); do echo "$L" | grep -q "che779-$V-$VER-linux/$f\$" || fail "tar $V thiếu $f"; done
  echo "$L" | grep -q "$NOT" && fail "tar $V chứa nhầm $NOT"
  tar -C "$T" -xzf "$TAR"
  [ "$("$T/che779-$V-$VER-linux/che779-$V" --version)" = "$WANT" ] || fail "che779-$V --version (tar)"
  if command -v dpkg-deb >/dev/null; then
    bash "$ROOT/scripts/package-deb.sh" "$V" "$JARS" "$T/out" >/dev/null
    DEB="$T/out/che779-${V}_${VER}_all.deb"; [ -f "$DEB" ] || fail "thiếu deb $V"
    C="$(dpkg-deb -c "$DEB")"
    for f in usr/bin/che779-$V usr/share/applications/che779-$V.desktop $(for j in $JL; do echo usr/share/che779-$V/$j; done); do echo "$C" | grep -q "\./$f\$" || fail "deb $V thiếu $f"; done
    [ "$(dpkg-deb -f "$DEB" Package)" = "che779-$V" ] || fail "tên gói deb $V sai"
    [ "$(dpkg-deb -f "$DEB" Version)" = "$VER" ] || fail "phiên bản deb $V sai"
    dpkg-deb -f "$DEB" Depends | grep -q "default-jre" || fail "deb $V thiếu phụ thuộc Java"
    dpkg-deb -x "$DEB" "$T/deb$V"
    [ "$("$T/deb$V/usr/bin/che779-$V" --version)" = "$WANT" ] || fail "che779-$V --version (deb)"
  else echo "(bỏ qua kiểm tra .deb: không có dpkg-deb)"; fi
done
echo "ĐẠT: kiểm thử gói v1 và v2"

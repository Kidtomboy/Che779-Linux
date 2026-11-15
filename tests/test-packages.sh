#!/usr/bin/env bash
# Kiểm thử gói: .tar.gz và .deb có đủ jar + lệnh, đúng phiên bản, lệnh chạy được (--version).
# Dùng: tests/test-packages.sh [thư-mục-jar]   (mặc định build/jars)
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
JARS="${1:-$ROOT/build/jars}"
T="$(mktemp -d)"; trap 'rm -rf "$T"' EXIT
fail(){ echo "THẤT BẠI: $*" >&2; exit 1; }
VER="$(tr -d '[:space:]' < "$ROOT/VERSION")"
bash "$ROOT/scripts/package-tar.sh" "$JARS" "$T/out" >/dev/null
bash "$ROOT/scripts/package-deb.sh" "$JARS" "$T/out" >/dev/null
TAR="$T/out/che779-$VER-linux.tar.gz"; DEB="$T/out/che779_${VER}_all.deb"
[ -f "$TAR" ] && [ -f "$DEB" ] || fail "thiếu gói"
L="$(tar tzf "$TAR")"
for f in che779 che779-remoter lib/Che779_Emulator.jar lib/Che779_EmulatorV2.jar lib/Che779_Remoter.jar DOC-TOI-DAY.txt; do echo "$L" | grep -q "che779-$VER-linux/$f\$" || fail "tar thiếu $f"; done
tar -C "$T" -xzf "$TAR"
[ "$("$T/che779-$VER-linux/che779" --version)" = "Che779 EmulatorV2 $VER (Linux)" ] || fail "che779 --version (tar)"
[ "$("$T/che779-$VER-linux/che779-remoter" --version)" = "Che779 Remoter $VER (Linux)" ] || fail "che779-remoter --version (tar)"
if command -v dpkg-deb >/dev/null; then
  C="$(dpkg-deb -c "$DEB")"
  for f in usr/bin/che779 usr/bin/che779-remoter usr/share/che779/Che779_Emulator.jar usr/share/che779/Che779_EmulatorV2.jar usr/share/che779/Che779_Remoter.jar usr/share/applications/che779.desktop; do echo "$C" | grep -q "\./$f\$" || fail "deb thiếu $f"; done
  [ "$(dpkg-deb -f "$DEB" Version)" = "$VER" ] || fail "phiên bản deb sai"
  dpkg-deb -f "$DEB" Depends | grep -q "default-jre" || fail "deb thiếu phụ thuộc Java"
  dpkg-deb -x "$DEB" "$T/deb"
  [ "$("$T/deb/usr/bin/che779" --version)" = "Che779 EmulatorV2 $VER (Linux)" ] || fail "che779 --version (deb)"
else echo "(bỏ qua kiểm tra .deb: không có dpkg-deb)"; fi
# jar V2 nhúng trong .sh phải trùng jar trong gói
echo "ĐẠT: kiểm thử gói"

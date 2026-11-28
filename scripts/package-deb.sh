#!/usr/bin/env bash
# Tạo che779-<v1|v2>_<phiên bản>_all.deb (Ubuntu/Mint/Debian). Java khai báo là phụ thuộc: apt tự cài gói chính thức.
# Hai gói độc lập, cài song song được: che779-v1 (lệnh che779-v1) và che779-v2 (lệnh che779-v2).
# Dùng: scripts/package-deb.sh <v1|v2> [thư-mục-jar] [thư-mục-ra]
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
V="${1:?Dùng: package-deb.sh <v1|v2> [thư-mục-jar] [thư-mục-ra]}"
JARS="${2:-$ROOT/build/jars}"; OUT="${3:-$ROOT/dist}"
VER="$(tr -d '[:space:]' < "$ROOT/VERSION")"
command -v dpkg-deb >/dev/null || { echo "Cần dpkg-deb (Debian/Ubuntu)." >&2; exit 1; }
case "$V" in
  v1) NEED="Che779_Emulator.jar Che779_Remoter.jar"; TITLE="Emulator V1 + Remoter Linux (mỗi tab một cửa sổ)";;
  v2) NEED="Che779_EmulatorV2.jar"; TITLE="Emulator V2 (nhiều tab trong một cửa sổ)";;
  *) echo "Chỉ nhận v1 hoặc v2" >&2; exit 2;;
esac
for j in $NEED; do [ -f "$JARS/$j" ] || { echo "Thiếu $JARS/$j" >&2; exit 1; }; done
T="$(mktemp -d)"; trap 'rm -rf "$T"' EXIT
PKG="che779-$V"; P="$T/${PKG}_${VER}_all"
mkdir -p "$P/DEBIAN" "$P/usr/bin" "$P/usr/share/$PKG" "$P/usr/share/applications"
for j in $NEED; do cp "$JARS/$j" "$P/usr/share/$PKG/"; done
sed "s/@VERSION@/$VER/" "$ROOT/apps/linux/packaging/$PKG" > "$P/usr/bin/$PKG"; chmod 755 "$P/usr/bin/$PKG"; bash -n "$P/usr/bin/$PKG"
cp "$ROOT/apps/linux/packaging/$PKG.desktop" "$P/usr/share/applications/"
chmod 644 "$P"/usr/share/$PKG/*.jar "$P"/usr/share/applications/*.desktop
SIZE=$(du -sk "$P/usr" | cut -f1)
cat > "$P/DEBIAN/control" <<EOC
Package: $PKG
Version: $VER
Section: games
Priority: optional
Architecture: all
Depends: default-jre | openjdk-21-jre | openjdk-17-jre | openjdk-11-jre | openjdk-8-jre
Recommends: xdotool, fonts-dejavu, xvfb
Installed-Size: $SIZE
Maintainer: Cherry <noreply@users.noreply.github.com>
Homepage: https://github.com/Kidtomboy/Che779-Linux
Description: Che779 ${V^^} - giả lập game Java J2ME cho Linux
 $TITLE. Lệnh: $PKG
EOC
mkdir -p "$OUT"
dpkg-deb --root-owner-group --build "$P" "$OUT/${PKG}_${VER}_all.deb" >/dev/null
echo "OK: $OUT/${PKG}_${VER}_all.deb"

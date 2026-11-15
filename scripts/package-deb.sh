#!/usr/bin/env bash
# Tạo che779_<phiên bản>_all.deb (Ubuntu/Mint/Debian). Java khai báo là phụ thuộc: apt tự cài gói chính thức.
# Dùng: scripts/package-deb.sh [thư-mục-jar] [thư-mục-ra]
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
JARS="${1:-$ROOT/build/jars}"; OUT="${2:-$ROOT/dist}"
VER="$(tr -d '[:space:]' < "$ROOT/VERSION")"
command -v dpkg-deb >/dev/null || { echo "Cần dpkg-deb (Debian/Ubuntu)." >&2; exit 1; }
for j in Che779_Emulator.jar Che779_EmulatorV2.jar Che779_Remoter.jar; do [ -f "$JARS/$j" ] || { echo "Thiếu $JARS/$j" >&2; exit 1; }; done
T="$(mktemp -d)"; trap 'rm -rf "$T"' EXIT
P="$T/che779_${VER}_all"
mkdir -p "$P/DEBIAN" "$P/usr/bin" "$P/usr/share/che779" "$P/usr/share/applications"
cp "$JARS"/Che779_*.jar "$P/usr/share/che779/"
for s in che779 che779-remoter; do sed "s/@VERSION@/$VER/" "$ROOT/apps/linux/packaging/$s" > "$P/usr/bin/$s"; chmod 755 "$P/usr/bin/$s"; bash -n "$P/usr/bin/$s"; cp "$ROOT/apps/linux/packaging/$s.desktop" "$P/usr/share/applications/"; done
chmod 644 "$P"/usr/share/che779/*.jar "$P"/usr/share/applications/*.desktop
SIZE=$(du -sk "$P/usr" | cut -f1)
cat > "$P/DEBIAN/control" <<EOF
Package: che779
Version: $VER
Section: games
Priority: optional
Architecture: all
Depends: default-jre | openjdk-21-jre | openjdk-17-jre | openjdk-11-jre | openjdk-8-jre
Recommends: xdotool, fonts-dejavu, xvfb
Installed-Size: $SIZE
Maintainer: Cherry <noreply@users.noreply.github.com>
Homepage: https://github.com/Kidtomboy/Che779-Linux
Description: Che779 - giả lập game Java J2ME cho Linux
 Gồm Emulator V2 (nhiều tab trong một cửa sổ: lệnh che779) và Emulator V1
 cùng Remoter Linux (mỗi tab một cửa sổ: lệnh che779-remoter).
EOF
mkdir -p "$OUT"
dpkg-deb --root-owner-group --build "$P" "$OUT/che779_${VER}_all.deb" >/dev/null
echo "OK: $OUT/che779_${VER}_all.deb"

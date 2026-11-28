#!/usr/bin/env bash
# Kiểm thử che779-linux-v1.sh và che779-linux-v2.sh: cú pháp, trợ giúp, phiên bản, giải nén có kiểm tra SHA-256, từ chối dữ liệu sai.
# Dùng: tests/test-script.sh [thư-mục-jar]   (mặc định build/jars)
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
JARS="${1:-$ROOT/build/jars}"
T="$(mktemp -d)"; trap 'rm -rf "$T"' EXIT
fail(){ echo "THẤT BẠI: $*" >&2; exit 1; }
VER="$(tr -d '[:space:]' < "$ROOT/VERSION")"
bash -n "$ROOT/apps/linux/che779-linux.sh" || fail "bản nguồn sai cú pháp"
ZERO=0000000000000000000000000000000000000000000000000000000000000000
for V in v1 v2; do
  "$ROOT/scripts/build-release.sh" "$V" "$JARS" "$T/out" >/dev/null
  S="$T/out/che779-linux-$V.sh"; U="$(echo "$V" | tr a-z A-Z)"
  [ "$(bash "$S" --version)" = "Che779 Linux $U $VER" ] || fail "$V --version sai"
  bash "$S" --help | grep -q -- '--doctor' || fail "$V --help thiếu nội dung"
  CHE_DRY=1 CHE_OUT="$T/x$V" bash "$S" >/dev/null 2>&1 || fail "$V dry-run thất bại"
  if [ "$V" = v2 ]; then
    [ "$(sha256sum "$T/x$V/Che779_EmulatorV2.jar" | cut -d' ' -f1)" = "$(sha256sum "$JARS/Che779_EmulatorV2.jar" | cut -d' ' -f1)" ] || fail "v2: jar giải nén khác jar gốc"
  else
    for j in Che779_Emulator.jar Che779_Remoter.jar; do
      [ "$(sha256sum "$T/x$V/$j" | cut -d' ' -f1)" = "$(sha256sum "$JARS/$j" | cut -d' ' -f1)" ] || fail "v1: $j giải nén khác bản gốc"
    done
  fi
  sed "s/^CHE_JAR_SHA256=\"[0-9a-f]*\"/CHE_JAR_SHA256=\"$ZERO\"/" "$S" > "$T/bad$V.sh"
  if CHE_DRY=1 CHE_OUT="$T/y$V" bash "$T/bad$V.sh" >/dev/null 2>&1; then fail "$V vẫn chạy dù SHA-256 sai"; fi
  # script V1 không được chạy với dữ liệu V2 và ngược lại (đổi nhãn biến thể)
  OTHER=v1; [ "$V" = v1 ] && OTHER=v2
  sed "s/^CHE_VARIANT=\"$V\"/CHE_VARIANT=\"$OTHER\"/" "$S" > "$T/swap$V.sh"
  if CHE_DRY=1 CHE_OUT="$T/s$V" bash "$T/swap$V.sh" >/dev/null 2>&1; then fail "$V bị đổi nhãn vẫn chạy"; fi
  if CHE_DRY=1 CHE_OUT="$T/z$V" bash "$ROOT/apps/linux/che779-linux.sh" >/dev/null 2>&1; then fail "bản nguồn không được phép chạy"; fi
  mkdir -p "$T/bin$V"; for t in bash sed base64 head od tr mkdir mv rm cut sha256sum dirname tput cat date uname id tar gzip; do p="$(command -v $t || true)"; [ -n "$p" ] && ln -sf "$p" "$T/bin$V/$t"; done
  PATH="$T/bin$V" CHE_DRY=1 CHE_OUT="$T/w$V" "$T/bin$V/bash" "$S" >/dev/null 2>&1 || fail "$V không chạy được khi thiếu unzip"
done
echo "ĐẠT: tất cả kiểm thử script (v1 và v2)"

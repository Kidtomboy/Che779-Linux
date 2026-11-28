#!/usr/bin/env bash
# Kiểm thử script Termux v1 và v2: cú pháp, trợ giúp, phiên bản, giải nén jar có kiểm tra SHA-256, từ chối jar sai mã.
# Dùng: tests/test-termux.sh [thư-mục-jar]   (mặc định build/termux; cần Che779_Emulator.jar và Che779_EmulatorV2.jar)
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"; TX="$ROOT/apps/termux"
JARS="${1:-$ROOT/build/termux}"
T="$(mktemp -d)"; trap 'rm -rf "$T"' EXIT
export CHE_FORCE_OS=termux   # CI chạy trên Linux: giả lập Termux để thử đường giải nén jar
fail(){ echo "THẤT BẠI: $*" >&2; exit 1; }
VER="$(tr -d '[:space:]' < "$TX/VERSION")"
bash -n "$TX/che779-termux.sh" || fail "bản nguồn sai cú pháp"
ZERO=0000000000000000000000000000000000000000000000000000000000000000
for V in v1 v2; do
  case "$V" in v1) JN=Che779_Emulator.jar;; v2) JN=Che779_EmulatorV2.jar;; esac
  JAR="$JARS/$JN"; [ -f "$JAR" ] || fail "thiếu $JAR"
  S="$T/out/che779-termux-$V.sh"; U="$(echo "$V" | tr a-z A-Z)"
  "$TX/build-termux.sh" "$V" "$JAR" "$S" >/dev/null
  [ "$(bash "$S" --version)" = "Che779 Termux $U $VER" ] || fail "$V --version sai"
  bash "$S" --help | grep -q -- '--doctor' || fail "$V --help thiếu nội dung"
  CHE_DRY=1 CHE_OUT="$T/x$V" bash "$S" >/dev/null 2>&1 || fail "$V dry-run thất bại"
  [ "$(sha256sum "$T/x$V/$JN" | cut -d' ' -f1)" = "$(sha256sum "$JAR" | cut -d' ' -f1)" ] || fail "$V: jar giải nén khác jar gốc"
  sed "s/^CHE_JAR_SHA256=\"[0-9a-f]*\"/CHE_JAR_SHA256=\"$ZERO\"/" "$S" > "$T/bad$V.sh"
  if CHE_DRY=1 CHE_OUT="$T/y$V" bash "$T/bad$V.sh" >/dev/null 2>&1; then fail "$V vẫn chạy dù SHA-256 sai"; fi
  if CHE_DRY=1 CHE_OUT="$T/z$V" bash "$TX/che779-termux.sh" >/dev/null 2>&1; then fail "bản nguồn không được phép chạy"; fi
  mkdir -p "$T/bin$V"; for t in bash sed base64 head od tr mkdir mv rm cut sha256sum dirname tput cat date uname id; do p="$(command -v $t || true)"; [ -n "$p" ] && ln -sf "$p" "$T/bin$V/$t"; done
  PATH="$T/bin$V" CHE_DRY=1 CHE_OUT="$T/w$V" "$T/bin$V/bash" "$S" >/dev/null 2>&1 || fail "$V không chạy được khi thiếu unzip"
done
echo "ĐẠT: tất cả kiểm thử script Termux (v1 và v2)"

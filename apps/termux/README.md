# Termux — Che779 Emulator V2

Script một file chạy **Emulator V2** trong Termux (Android). Termux chạy qua `proot-distro` (Ubuntu) + Java + Openbox + Termux:X11.
Phần này trước ở Che779-Android (`termux/`), đã chuyển sang Che779-Linux (`apps/termux/`) vì Termux cập nhật theo nhịp riêng, ít người dùng và không cần phát hành chung với app Android.

## Dùng
1. Cài Termux và Termux:X11.
2. Tải `che779-termux.sh` ở Releases (thẻ `termux-v*`) → `bash che779-termux.sh` (tùy chọn: `-r MB`, `-g TÊN_GAME`, `--net`, `--doctor`, `--reset`, `-V`, `-h`).
3. Game: `Download/Che779Games`; dữ liệu: `Download/Che779Data`.
Bản Linux máy tính là file khác: `che779-linux.sh` (thẻ `v*`).

## Cách làm ra file
- `apps/termux/che779-termux.sh`: **bản nguồn** (có `@VERSION@`, `@JAR_SHA256@`, `@JAR_NAME@`, chưa có jar).
- `apps/termux/build-termux.sh <jar> <tên-jar> <file-ra>`: tính SHA-256 từ chính jar, điền vào script, nối jar base64.
- `apps/termux/fetch-jar.sh v2|v1`: lấy Che779-EmulatorV2 (hoặc Che779-Emulator) đúng commit trong `EMULATOR_V2_REF` (hoặc `test/EMULATOR_V1_REF`) và build jar vào `build/termux/`.
- `bash tests/test-termux.sh <jar>`: kiểm thử (SHA-256, từ chối jar sai, không cần `unzip`; giả lập Termux bằng `CHE_FORCE_OS=termux`).
- Phiên bản riêng: `apps/termux/VERSION` (giữ nguyên cho tới khi Cherry yêu cầu nâng).
- Workflow riêng: `.github/workflows/ci-termux.yml`, `release-termux.yml`.

## Thử nghiệm V1 (không hỗ trợ chính thức)
V1 chạy một game một cửa sổ. Mỗi lần phát hành, workflow tạo `che779-termux-v1-test.sh` trong **artifact** `termux-v1-test` của lần chạy Actions (không đưa vào Releases). Chưa thử trên Termux thật.

## Đã thử / chưa thử
- **Đã thử:** Cherry thử trên Termux thật (bản script cũ ở Che779-Linux): chạy được, chơi được game.
- **Đã thử trong môi trường Claude:** ghép script, kiểm thử SHA-256, dry-run.
- **Chưa thử:** bản sau khi tách khỏi Che779-Linux rồi chuyển qua Che779-Android và nay về lại Che779-Linux chưa được chạy lại trên Termux thật.

# Termux — Che779 Emulator V1 và V2

Hai script một file riêng, `che779-termux-v1.sh` (**Emulator V1**) và `che779-termux-v2.sh` (**Emulator V2**), chạy trong Termux (Android). Termux chạy qua `proot-distro` (Ubuntu) + Java + Openbox + Termux:X11.
Phần này trước ở Che779-Android (`termux/`), đã chuyển sang Che779-Linux (`apps/termux/`) vì Termux cập nhật theo nhịp riêng, ít người dùng và không cần phát hành chung với app Android.

## Dùng
1. Cài Termux và Termux:X11.
2. Tải `che779-termux-v2.sh` (hoặc `che779-termux-v1.sh`) ở Releases (thẻ `termux-v*`) → `bash che779-termux-v2.sh` (tùy chọn: `-r MB`, `-g TÊN_GAME`, `--net`, `--doctor`, `--reset`, `-V`, `-h`).
3. Game: `Download/Che779Games`; dữ liệu: `Download/Che779Data`.
Bản Linux máy tính là file khác: `che779-linux-v1.sh` / `-v2.sh` (thẻ `v*`). V1 và V2 dùng thư mục làm việc riêng (`che779_share_v1`, `che779_share_v2`), chung phần môi trường đã cài.

## Cách làm ra file
- `apps/termux/che779-termux.sh`: **bản nguồn** (có `@VERSION@`, `@JAR_SHA256@`, `@JAR_NAME@`, `@VARIANT@`, chưa có jar).
- `apps/termux/build-termux.sh <v1|v2> <jar> <file-ra>`: tính SHA-256 từ chính jar, điền vào script, nối jar base64.
- `apps/termux/fetch-jar.sh v2|v1`: lấy Che779-EmulatorV2 (hoặc Che779-Emulator) đúng commit trong `EMULATOR_V2_REF` (hoặc `EMULATOR_V1_REF`) ở gốc repo (dùng chung với Linux) và build jar vào `build/termux/`.
- `bash tests/test-termux.sh [thư-mục-jar]` (cần cả hai jar; chạy fetch-jar.sh v1 và v2 trước): kiểm thử v1 và v2 (SHA-256, từ chối jar sai, không cần `unzip`; giả lập Termux bằng `CHE_FORCE_OS=termux`).
- Phiên bản riêng: `apps/termux/VERSION` (giữ nguyên cho tới khi Cherry yêu cầu nâng).
- Workflow riêng: `.github/workflows/ci-termux.yml`, `release-termux.yml`.

## V1 và V2
- **V2**: nhiều tab trong một cửa sổ (một tiến trình). **V1**: mỗi game một tiến trình riêng, không có Remoter (Remoter chỉ có trên Linux máy tính). Cả hai là bản chính thức, đều nằm ở Releases. **V1 trên Termux chưa thử trên máy thật.**

## Đã thử / chưa thử
- **Đã thử:** Cherry thử trên Termux thật (bản script cũ ở Che779-Linux): chạy được, chơi được game.
- **Đã thử trong môi trường Claude:** ghép script, kiểm thử SHA-256, dry-run.
- **Chưa thử:** bản sau khi tách khỏi Che779-Linux rồi chuyển qua Che779-Android và nay về lại Che779-Linux chưa được chạy lại trên Termux thật.

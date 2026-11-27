# Nhật ký thay đổi

Chỉ ghi những gì **phiên bản hiện tại** có. Lịch sử các bản trước không còn được lưu ở đây.

## Chưa phát hành (giữ phiên bản 1.3.0 cho tới khi Cherry yêu cầu nâng)

- **Termux chuyển về repo này** (`apps/termux/`), từ Che779-Android. Có `VERSION` riêng (1.3.0), workflow riêng `ci-termux.yml` / `release-termux.yml` (thẻ `termux-v*`).
- **Đổi tên file Linux:** `che779.sh` → `che779-linux.sh` (nguồn `apps/linux/che779-linux.sh`) để không lẫn với `che779-termux.sh`.
- **Workflow tách riêng:** `ci-linux.yml`, `release-linux.yml` (thẻ `v*`), `ci-termux.yml`, `release-termux.yml`; mỗi cái chỉ chạy khi file liên quan đổi.

## [1.3.0] — Bản phát hành (chỉ Linux)

- **Chỉ dành cho Linux.** (Termux từng chuyển sang Che779-Android, nay đã về lại repo này.)
- **Gói `.deb`** (Ubuntu/Mint/Debian; phụ thuộc Java chính thức) và **`.tar.gz`** (mọi distro), mỗi gói có hai lệnh: `che779` (Emulator V2) và `che779-remoter` (Emulator V1 + Remoter Linux).
- **Remoter Linux** (chuyển từ Che779-Emulator): giao diện 6 khu vực bám Remoter Windows, cột CPU/RAM/PID, hồ sơ, tự mở lại tab, tự Clean RAM, canh RAM, hẹn giờ đóng, sắp xếp tab bằng `xdotool` (X11). Chưa có: Xem lưới, Macro.
- **`che779.sh`** một file chạy V2 (giữ tạm): kiểm tra jar nhúng (đầu tệp ZIP + SHA-256), tự cài Java bằng gói chính thức của distro (apt/dnf/pacman/apk/zypper), màn hình ảo Xvfb khi không có màn hình; tùy chọn `-r`, `-g`, `--net`, `--doctor`, `-V`, `-h`.
- **Mã V1/V2 không chép vào repo**: Actions lấy từ Che779-Emulator / Che779-EmulatorV2 đúng commit ghim trong `apps/linux/EMULATOR_V1_REF`, `EMULATOR_V2_REF`.
- Phát hành tự động khi gắn thẻ `vX.Y.Z`: `.deb`, `.tar.gz`, `che779.sh` và `SHA256SUMS.txt` (tính sau cùng trên đúng file đăng).

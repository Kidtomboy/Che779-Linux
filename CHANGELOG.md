# Nhật ký thay đổi

Chỉ ghi những gì **phiên bản hiện tại** có. Lịch sử các bản trước không còn được lưu ở đây.

## [1.2.0] — Bản phát hành

- **Một file `che779.sh`** chứa sẵn Che779 EmulatorV2 1.2.0, tự nhận diện hệ điều hành: Linux (Debian/Ubuntu/Mint, Fedora/RHEL, Arch/Manjaro, Alpine, openSUSE, WSL) và **Termux** trên Android.
- **Linux:** kiểm tra Java, thiếu thì cài bằng gói **chính thức của distro** (cần `sudo`); không cần tải hay giải nén thủ công; không cần `unzip`. Có màn hình ảo Xvfb nếu máy không có màn hình.
- **Termux:** cài Ubuntu bằng `proot-distro`, Java, Openbox và Termux:X11 rồi mở emulator. Chủ dự án đã thử: chạy được và chơi được game.
- **Kiểm tra toàn vẹn:** jar nhúng được kiểm tra đầu tệp ZIP và mã **SHA-256** (điền lúc đóng gói, tính từ chính jar); sai mã thì từ chối chạy.
- Tùy chọn: `-r/--ram`, `-g/--game`, `--net` (kiểm tra mạng và cổng game), `--doctor`, `--reset`, `-V/--version`, `-h/--help`; kiểu cũ `bash che779.sh 1024 build11` vẫn chạy.
- Giao diện terminal có khung, màu, vòng quay chờ, dấu ✔ ✘ ▲ và bảng thông tin môi trường.
- Phát hành tự động: gắn thẻ `vX.Y.Z` → build jar V2 từ phiên bản đã ghim, ghép script, kiểm thử, tạo `che779.sh` + `SHA256SUMS.txt`.

# Nhật ký thay đổi

Chỉ ghi những gì **phiên bản hiện tại** có. Lịch sử các bản trước không còn được lưu ở đây.

## [1.3.1] — Bản phát hành

- **Termux về repo này** (`apps/termux/`, từ Che779-Android): hai script `che779-termux-v1.sh` (V1) và `che779-termux-v2.sh` (V2), `VERSION` riêng (cùng số 1.3.1), thẻ phát hành `termux-v1.3.1`.
- **Tách V1 / V2:** mọi file phát hành có `-v1` hoặc `-v2` trong tên: `che779-linux-v1.sh` / `-v2.sh`, `che779-v1-<ver>-linux.tar.gz` / `che779-v2-...`, `che779-v1_<ver>_all.deb` / `che779-v2_...` (lệnh `che779-v1`, `che779-v2`; hai gói cài song song được), `che779-termux-v1.sh` / `-v2.sh`. V1 = Emulator V1 + Remoter Linux, V2 = Emulator V2. Lệnh cũ `che779` và `che779-remoter` không còn.
- **Workflow tách riêng:** `ci-linux.yml` và `release-linux.yml` (thẻ `v*`); `ci-termux.yml` và `release-termux.yml` (thẻ `termux-v*`). CI chỉ chạy khi file liên quan đổi; Phát hành kiểm tra thẻ khớp `VERSION`.
- **Ghim lại mã P1 và P2 ở bản 1.3.1** (V1 `833ad6e`, V2 `ef98850`) để nhận các sửa lỗi mới (chụp ảnh chỉ ghi `.png`; sửa an toàn luồng ở V2).
- **Gói `.deb`** (Ubuntu/Mint/Debian; phụ thuộc Java chính thức) và **`.tar.gz`** (mọi distro), mỗi gói chỉ chứa V1 (+ Remoter) hoặc V2; script một file kiểm tra dữ liệu nhúng (đầu tệp ZIP hoặc gzip + SHA-256), tự cài Java bằng gói chính thức của distro.
- **Remoter Linux** (chuyển từ Che779-Emulator): giao diện 6 khu vực, cột CPU/RAM/PID, hỗ trợ Xem lưới.
- **Mã V1/V2 không chép vào repo**: Actions lấy từ Che779-Emulator / Che779-EmulatorV2 đúng commit ghim.
- Phát hành tự động khi gắn thẻ; `SHA256SUMS.txt` tính sau cùng trên đúng file đăng.

# Nhật ký thay đổi

Chỉ ghi những gì **phiên bản hiện tại** có. Lịch sử các bản trước không còn được lưu ở đây.

## [1.3.1] — Bản phát hành

- **Termux về repo này** (`apps/termux/`, từ Che779-Android): script `che779-termux.sh` (chỉ V2 chính thức), `VERSION` riêng (cùng số 1.3.1), thẻ phát hành `termux-v1.3.1`. Bản V1 thử nghiệm chỉ là artifact của Actions.
- **Đổi tên file Linux:** `che779.sh` → `che779-linux.sh`, không lẫn với `che779-termux.sh`.
- **Workflow tách riêng:** `ci-linux.yml` và `release-linux.yml` (thẻ `v*`); `ci-termux.yml` và `release-termux.yml` (thẻ `termux-v*`). CI chỉ chạy khi file liên quan đổi; Phát hành kiểm tra thẻ khớp `VERSION`.
- **Ghim lại mã P1 và P2 ở bản 1.3.1** (V1 `833ad6e`, V2 `ef98850`) để nhận các sửa lỗi mới (chụp ảnh chỉ ghi `.png`; sửa an toàn luồng ở V2).
- **Gói `.deb`** (Ubuntu/Mint/Debian; phụ thuộc Java chính thức) và **`.tar.gz`** (mọi distro), mỗi gói có V1, V2 và Remoter Linux; `che779-linux.sh` một file chạy V2 (giữ tạm), kiểm tra jar nhúng (đầu tệp ZIP + SHA-256), tự cài Java bằng gói chính thức của distro.
- **Remoter Linux** (chuyển từ Che779-Emulator): giao diện 6 khu vực, cột CPU/RAM/PID, hỗ trợ Xem lưới.
- **Mã V1/V2 không chép vào repo**: Actions lấy từ Che779-Emulator / Che779-EmulatorV2 đúng commit ghim.
- Phát hành tự động khi gắn thẻ; `SHA256SUMS.txt` tính sau cùng trên đúng file đăng.

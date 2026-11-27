# Chính sách bảo mật

## Báo lỗi bảo mật

Nếu bạn tìm thấy lỗ hổng, **đừng đăng công khai** trong Issue. Hãy dùng mục *Security → Report a vulnerability* của repo trên GitHub để báo riêng.

## Điều cần biết

| Vấn đề | Ghi chú |
|---|---|
| Script cài gói bằng `sudo` | Chỉ cài gói Java/Xvfb chính thức của distro khi thiếu. Hãy đọc script trước khi chạy nếu bạn không tin nguồn. |
| Jar được nhúng sẵn | Kiểm tra đầu tệp ZIP và SHA-256 (điền lúc đóng gói). Mã này bảo vệ khỏi tải hỏng/bị sửa jar **sau khi** đóng gói; nó không thay cho việc kiểm tra `SHA256SUMS.txt` của chính `che779-linux.sh`. |
| Danh sách máy chủ game tải bằng HTTP thường | Chỉ dùng cho lệnh `--net`; chưa có kiểm tra toàn vẹn. |
| IPC của emulator chưa xác thực | Xem `SECURITY.md` của [Che779-EmulatorV2](https://github.com/Kidtomboy/Che779-EmulatorV2). |
| Gói `.deb`/`.tar.gz` | Chỉ chứa jar và hai lệnh; không có script cài đặt chạy với quyền root ngoài việc `apt` cài gói. Kiểm tra bằng `SHA256SUMS.txt`. |

## Dữ liệu người dùng

- Dữ liệu ở `~/.che779`, game ở `~/Che779Games`.
- Script không gửi dữ liệu của bạn ra ngoài; chỉ lệnh `--net` mới kết nối mạng để kiểm tra.

## Tải bản chính thức

Chỉ tải file từ mục **Releases** của repo chính thức và kiểm tra bằng `SHA256SUMS.txt`.

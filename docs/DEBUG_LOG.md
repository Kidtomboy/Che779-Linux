# Nhật ký lỗi

Chỉ ghi vấn đề còn liên quan tới phiên bản hiện tại.

| Vấn đề | Trạng thái |
|---|---|
| SHA-256 từng bị tính trước khi script sửa xong | **Đã khắc phục**: mã tính tự động từ jar lúc đóng gói, có kiểm thử |
| Phải cài `unzip`/tải tay trên Ubuntu | **Đã khắc phục**: không cần `unzip`; Java dùng gói chính thức; có `.deb` |
| `.deb` trên Debian/Mint thật | **Chưa thử** (mới cài thử trên Ubuntu 24.04 trong môi trường Claude) |
| `che779.sh` tự cài Java trên Fedora/Arch/Alpine/openSUSE | **Chưa thử** |
| Sắp xếp tab bằng `xdotool` | **Chưa thử** |

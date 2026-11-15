# Nhật ký lỗi

Chỉ ghi vấn đề còn liên quan tới phiên bản hiện tại.

| Vấn đề | Trạng thái |
|---|---|
| Mã SHA-256 từng bị tính trước khi script sửa xong, gây lỗi kiểm tra | **Đã khắc phục**: mã tính tự động từ jar lúc đóng gói, có kiểm thử. |
| Lệnh `od -c` sai khi kiểm tra đầu ZIP | **Đã khắc phục**: so `od -An -tx1` với `504b0304`. |
| Phải cài `unzip`/tải tay trên Ubuntu | **Đã khắc phục**: không còn cần `unzip`; Java cài bằng gói chính thức. |
| Đường cài tự động trên Fedora/Arch/Alpine/openSUSE | **Chưa thử** trên máy thật. |

# Ma trận kiểm thử Project 3

| Nhóm | Ca kiểm thử | Kết quả mong đợi |
|---|---|---|
| Static | `bash -n` | Không lỗi cú pháp |
| Help | `--help` | Chỉ hiển thị trợ giúp, exit 0 |
| Diagnostics | `--doctor` | Báo đủ Java, display, paths, permissions |
| Network | `--net` khi có mạng | Exit code 0 nếu đạt |
| Network | `--net` khi DNS/HTTP/TCP lỗi | Exit code khác 0 và nêu nguyên nhân |
| Offline | Chặn mạng rồi chạy portable | Không cố tải dependency |
| Integrity | JAR đúng checksum | Cho phép chạy |
| Integrity | JAR bị sửa 1 byte | Dừng trước khi chạy |
| Data safety | Update khi có games/save | Dữ liệu giữ nguyên |
| Data safety | Uninstall mặc định | Runtime bị gỡ, data giữ nguyên |
| Data safety | Dry-run clean data | Chỉ liệt kê, không xóa |
| Paths | Đường dẫn có dấu cách | Cài/chạy thành công |
| Paths | Đường dẫn có Unicode | Hỗ trợ hoặc từ chối rõ ràng |
| Process | Ctrl-C / kill launcher | Cleanup đúng tiến trình con |
| Process | Chạy hai instance | Không kill nhầm instance khác |
| Linux GUI | X11/Wayland theo target | Mở UI hoặc thông báo thiếu dependency |
| Termux | Android thật + Termux:X11 | Khởi chạy, đóng và restart ổn định |
| OCI | Export/import image offline | Chạy được sau import |
| OCI | Volume data | Games/save tồn tại sau recreate container |
| Upgrade | Nâng từ bản trước | Data giữ nguyên, rollback được |

## Test gate

Không phát hành một target nếu chưa hoàn thành các test bắt buộc cho target đó. Test Linux không thay thế test Termux. Test container không thay thế test native Linux.

Ghi lại:
- thiết bị/OS/architecture
- Java distribution/version
- display backend
- package version và SHA-256
- lệnh chạy
- stdout/stderr và exit code
- kết quả pass/fail

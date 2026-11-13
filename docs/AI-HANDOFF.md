# AI handoff — Che779 Project 3

## Mục tiêu người dùng

Muốn Project 3 tiện như một runtime đóng gói sẵn: tải/copy gói một lần, sau đó chạy trực tiếp, không phụ thuộc chất lượng mạng mỗi lần khởi động. Docker-style packaging được quan tâm nhưng chưa bắt buộc phải là Docker-only.

## Quyết định thiết kế đề xuất

Offline-first multi-artifact:
- Linux portable bundle.
- Termux native bundle.
- OCI/Docker image tùy chọn cho Linux.
- User data tách khỏi runtime.
- Integrity verification và manifest cho mọi release.

## Bằng chứng từ rà soát ban đầu

- Đầu vào: script `che779.sh` được tìm thấy trong file library.
- Bash syntax check: pass.
- `--doctor`: pass trong môi trường kiểm tra.
- JAR nhúng giải nén được, cấu trúc hợp lệ.
- Emulator khởi chạy được trên Linux desktop test environment và IPC ping phản hồi.
- JAR nhúng khác JAR Project 2 đã build: có 68 entry class khác nội dung dù số entry bằng nhau.
- Script có lệnh `rm -rf` thư mục games trước khi đồng bộ.
- `--help` hiển thị nhầm một phần mã nguồn.
- `--net` chưa phản ánh thất bại qua exit code.
- Termux thực tế chưa được kiểm thử.

## Cảnh báo

Không được khẳng định:
- Project 3 đã hỗ trợ offline hoàn chỉnh.
- Project 3 đã chạy trên thiết bị Android thật.
- OCI image đã được build/test.
- JRE có thể được phân phối hợp pháp khi chưa audit license.
- JAR nhúng là bản mới nhất của Project 2.

## Thứ tự công việc tiếp theo

1. Lấy đúng source Project 2 và xác nhận revision/hash.
2. Tạo build pipeline tạo payload Project 3 từ nguồn chuẩn.
3. Sửa lỗi destructive data sync trước mọi tính năng khác.
4. Viết test launcher và integrity verification.
5. Build/test Linux portable.
6. Build/test Termux native trên thiết bị thật.
7. Bổ sung OCI target nếu Linux portable đã ổn.
8. Cập nhật tài liệu và release manifest.

## Quy tắc làm việc

- Không ghi đè file gốc nếu chưa có bản backup hoặc diff.
- Không xóa games/save.
- Không tuyên bố test pass nếu chưa chạy.
- Không tự chuyển sang Project 4 khi Project 3 chưa được người dùng duyệt.

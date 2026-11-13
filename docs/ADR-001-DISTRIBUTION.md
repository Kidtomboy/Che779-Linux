# ADR-001: Chọn mô hình phân phối offline-first, OCI tùy chọn

- **Trạng thái:** Đề xuất
- **Ngày:** 2026-11-13
- **Phạm vi:** Che779 Project 3

## Bối cảnh

Script bootstrap hiện tại có thể tải/cài thành phần tùy theo môi trường mạng. Điều này tạo trải nghiệm không ổn định trên mạng chậm hoặc khi offline. Ý tưởng “đóng gói như Docker” giải quyết một phần vấn đề nhưng Docker engine không phải dependency phổ quát, đặc biệt trên Termux.

## Quyết định đề xuất

Phân phối Project 3 theo mô hình **offline-first multi-artifact**:

1. Linux portable bundle là gói mặc định.
2. Termux native bundle là gói riêng.
3. OCI image là lựa chọn cho Linux có Podman/Docker.
4. Tất cả gói dùng manifest phiên bản và SHA-256.
5. User data được lưu ngoài payload và không bị xóa bởi installer/updater.

## Lựa chọn không chọn

### Docker-only

Không chọn làm định dạng duy nhất vì yêu cầu engine ở máy đích, xử lý GUI phức tạp và không phù hợp với Termux native.

### Downloader-only

Không chọn làm trải nghiệm mặc định vì phụ thuộc mạng và có thể tải lại thành phần vốn đã có.

### Một bundle duy nhất cho mọi hệ điều hành

Không chọn vì Java runtime, ABI, display stack và package path khác nhau giữa Linux desktop và Android/Termux.

## Hệ quả

- Cần pipeline build nhiều artifact.
- Cần quản lý phiên bản và checksum nghiêm ngặt.
- Kích thước tải lần đầu có thể lớn hơn.
- Người dùng có thể chạy offline sau khi đã có gói phù hợp.
- Cần xác minh giấy phép trước khi bundle runtime hoặc thư viện bên thứ ba.

## Điều kiện chấp thuận

ADR chỉ được xem là Accepted khi:
- Project owner duyệt hướng multi-artifact.
- Xác định Java runtime được bundle hay dùng system Java cho từng target.
- Xác minh license/NOTICE.
- Có kiểm thử trên Linux và thiết bị Termux thực tế.

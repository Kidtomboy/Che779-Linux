# Security, integrity và an toàn dữ liệu

## Rủi ro đã biết từ lượt rà soát script

1. Có thao tác xóa thư mục `games` trước khi đồng bộ. Đây là rủi ro mất dữ liệu trực tiếp.
2. Payload JAR chưa có bước xác minh checksum bắt buộc trước khi chạy.
3. Kiểm tra mạng có thể thất bại nhưng trả exit code thành công.
4. Quản lý tiến trình Termux:X11 cần giới hạn vào tiến trình do launcher sở hữu.
5. Các file cấu hình proxy có thể chứa thông tin nhạy cảm; không in nội dung vào log.

## Quy tắc dữ liệu

- Cấm `rm -rf` trên thư mục user data trong luồng install/update/uninstall mặc định.
- Uninstall mặc định chỉ xóa launcher/runtime; giữ nguyên data.
- Muốn xóa data phải có lệnh riêng, cảnh báo rõ, xác nhận tương tác và hỗ trợ dry-run.
- Update runtime theo mô hình staging: tải/giải nén vào thư mục tạm, verify, rồi đổi phiên bản nguyên tử nếu filesystem hỗ trợ.
- Giữ ít nhất một phiên bản runtime trước đó để rollback.
- Không đổi schema save/RMS nếu chưa có migration và backup.

## Integrity

Manifest nên chứa tối thiểu:
- package version
- source revision
- target OS/architecture
- Java runtime requirement
- file path, size, SHA-256
- build timestamp và build workflow identifier

Checksum giúp phát hiện hỏng hoặc sai lệch, nhưng không chứng minh nguồn phát hành đáng tin nếu manifest cũng bị thay thế. Release chính thức nên ký checksum/manifest bằng cơ chế chữ ký số và công bố public key/fingerprint qua kênh độc lập.

## Container

- Chạy non-root.
- Không mount Docker socket vào container.
- Không dùng `--privileged` trừ khi có lý do được chứng minh.
- Chỉ mount thư mục data cần thiết.
- Không bake secrets vào image.
- Pin base image và cập nhật định kỳ.
- Tài liệu GUI phải giải thích rõ quyền truy cập display socket.

## Logging

- Không log mật khẩu, token, proxy credential hoặc nội dung file cấu hình nhạy cảm.
- Log lỗi đủ để chẩn đoán nhưng không dump toàn bộ environment.
- Phân biệt rõ lỗi network, Java, display, integrity và permission.

## Giới hạn đánh giá

Đây là yêu cầu thiết kế dựa trên rà soát sơ bộ script, không phải security audit độc lập hay kiểm thử xâm nhập.

# Kiến trúc đề xuất

## 1. Mô hình

Project 3 gồm ba lớp tách biệt:

1. **Runtime payload:** Emulator JAR, thư viện, tài nguyên và (nếu được phép) Java runtime.
2. **Launcher:** phát hiện nền tảng, xác minh payload, chuẩn bị thư mục dữ liệu, dựng lệnh Java và quản lý tiến trình.
3. **Persistent user data:** games, RMS/saves, cấu hình, proxy và logs.

Launcher không được sở hữu hoặc xóa dữ liệu người dùng.

## 2. Luồng khởi chạy

```text
User
  |
  v
Launcher
  |
  +--> Detect platform (Linux / Termux)
  |
  +--> Verify package manifest + SHA-256
  |       |
  |       +--> fail: stop, explain, preserve data
  |
  +--> Resolve Java runtime
  |       |
  |       +--> bundled runtime, if available and licensed
  |       +--> otherwise compatible system Java
  |
  +--> Create missing data directories (non-destructive)
  |
  +--> Validate display / Termux:X11 prerequisites
  |
  +--> Start Emulator with explicit data/config paths
  |
  +--> Track PID and clean up only owned child processes
```

## 3. Offline-first

### Must be available offline

- Emulator JAR and required libraries.
- Launcher and default configuration.
- Platform metadata and checksum manifest.
- Help and diagnostics.
- Existing local games and user data.

### May require network

- First-time download of an optional runtime not bundled in the selected package.
- User-requested updates.
- User-requested game downloads or external resources.

Mọi thao tác cần mạng phải hiển thị rõ, có thể hủy, có timeout/retry hợp lý và không chạy ngầm ngoài ý muốn.

## 4. Docker/OCI có vai trò gì?

OCI image phù hợp cho Linux desktop/server hoặc môi trường CI có Podman/Docker. Có thể phân phối image dưới dạng archive (`save`/`load`) để máy đích không cần pull registry.

Tuy nhiên:
- Image OCI vẫn cần engine tương thích ở máy đích.
- Container không tự cung cấp display server; GUI cần cấu hình X11/Wayland hoặc VNC/noVNC.
- Container không phải cách phân phối native phù hợp cho Termux nói chung.
- Không nên nhét dữ liệu game/save vào image layer. Mount volume riêng.
- Image cần được build cho đúng kiến trúc CPU và ABI.

**Kết luận:** OCI là một target phân phối bổ sung, không phải định dạng duy nhất của Project 3.

## 5. Linux portable bundle

Một archive `.tar.zst` hoặc `.tar.gz` có thể chứa launcher, JAR, thư viện và cấu hình. Người dùng giải nén, chạy launcher. Nếu không bundle JRE, cần ghi rõ phiên bản Java tương thích và kiểm tra trước khi chạy.

Nếu bundle JRE:
- Chọn build đúng `x86_64`/`aarch64`.
- Kiểm tra giấy phép và quyền tái phân phối.
- Cân nhắc kích thước archive và cập nhật bảo mật.
- Không giả định một JRE Linux dùng được trên Android/Termux.

## 6. Termux native bundle

Termux cần gói riêng vì ABI, đường dẫn, package manager và Java runtime khác Linux desktop. Launcher có thể kiểm tra hoặc hướng dẫn cài các package Termux cần thiết, nhưng không nên giả định Docker daemon tồn tại.

Termux:X11 là thành phần host/display riêng; cần kiểm tra cài đặt và trạng thái trước khi mở GUI. Không tự ý kill mọi tiến trình có tên tương tự; chỉ dừng tiến trình do launcher tạo và quản lý.

## 7. Ranh giới dữ liệu

| Dữ liệu | Nơi lưu | Cập nhật runtime có được ghi đè? |
|---|---|---|
| Emulator JAR | `runtime/` | Có, sau integrity check và backup/rollback |
| Launcher | `launcher/` | Có |
| Default config | `config/defaults/` | Có |
| User config | `data/config/` | Không |
| Games | `data/games/` | Không |
| Saves/RMS | `data/saves/` hoặc vị trí emulator quy định | Không |
| Logs | `data/logs/` | Không |

Nếu emulator hiện tại lưu RMS trong một cấu trúc khác, cần khảo sát và ánh xạ chính xác trước khi triển khai. Không tự suy đoán vị trí save.

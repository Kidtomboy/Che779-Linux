# Roadmap triển khai Project 3

## Phase 0 — Chốt nguồn và baseline

- [ ] Chốt Project 2 revision/JAR làm nguồn chuẩn.
- [ ] Ghi SHA-256, kích thước, manifest và build metadata.
- [ ] So sánh toàn bộ JAR nhúng hiện tại với nguồn chuẩn.
- [ ] Xác minh entrypoint, Java version, native dependencies và tài nguyên.
- [ ] Lập inventory license/NOTICE.

**Exit criteria:** có thể tái tạo payload từ nguồn chuẩn và giải thích được mọi file được đóng gói.

## Phase 1 — Hardening launcher

- [ ] Loại bỏ `rm -rf` phá hủy thư mục games.
- [ ] Tạo backup/rollback khi cập nhật runtime.
- [ ] Xác minh checksum trước khi chạy.
- [ ] Sửa `--help`.
- [ ] Sửa exit code của `--net` và các lệnh diagnostics.
- [ ] Validate RAM, port, path và các tham số.
- [ ] Quoting mọi path; xử lý path có dấu cách.
- [ ] Dùng trap cleanup và quản lý PID do launcher sở hữu.
- [ ] Không để lộ credential trong log hoặc command line nếu có thể tránh.

**Exit criteria:** test lỗi không làm mất dữ liệu, launcher trả exit code chính xác và không để lại tiến trình con ngoài ý muốn.

## Phase 2 — Linux portable offline

- [ ] Build archive Linux cho kiến trúc đã chọn.
- [ ] Chọn system Java hoặc bundled JRE sau khi xác minh license.
- [ ] Cung cấp `install`/`run`/`doctor`/`verify`/`update` (nếu có) với hành vi rõ.
- [ ] Không có network call trong `run` mặc định.
- [ ] Test trên máy Linux sạch và máy offline.
- [ ] Kiểm thử X11/Wayland theo ma trận hỗ trợ.

**Exit criteria:** tải archive một lần, ngắt mạng, giải nén và khởi chạy thành công trên môi trường được hỗ trợ.

## Phase 3 — Termux native

- [ ] Chốt kiến trúc Android/ABI hỗ trợ.
- [ ] Kiểm tra package prerequisites mà không tự động cài nếu chưa có đồng ý.
- [ ] Tích hợp Termux:X11 theo quy trình rõ ràng.
- [ ] Quản lý wake lock và cleanup an toàn.
- [ ] Test trên thiết bị Android thật.
- [ ] Kiểm tra quyền storage và đường dẫn Termux.

**Exit criteria:** cài/chạy/dừng/restart không làm mất games, saves hoặc tiến trình ngoài phạm vi.

## Phase 4 — OCI image cho Linux

- [ ] Tạo Containerfile tối giản, pin base image theo digest.
- [ ] Non-root user.
- [ ] Mount volume cho data.
- [ ] Tài liệu X11/Wayland hoặc VNC.
- [ ] Health/diagnostic command.
- [ ] Build multi-arch nếu có năng lực kiểm thử.
- [ ] Export/import archive OCI để chuyển offline.
- [ ] Quét lỗ hổng và cập nhật base image.

**Exit criteria:** build image, export, chuyển sang máy không có mạng, import và chạy được với data volume riêng.

## Phase 5 — Release engineering

- [ ] CI build và test artifacts.
- [ ] Generate SHA256SUMS và release manifest.
- [ ] SBOM nếu khả thi.
- [ ] Changelog và migration notes.
- [ ] Test upgrade từ bản cũ; xác nhận dữ liệu giữ nguyên.
- [ ] Release source + portable Linux + Termux + OCI (nếu đạt).

**Exit criteria:** artifact có thể xác minh, tái tạo, nâng cấp và rollback theo tài liệu.

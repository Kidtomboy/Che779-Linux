# Trạng thái dự án (1.3.1)

| Hạng mục | Trạng thái |
|---|---|
| `.deb`, `.tar.gz`, `che779-linux-v1.sh`, `-v2.sh` | Build và kiểm thử được cục bộ + CI |
| `che779` (V2) từ `.deb`, Xvfb, game thật | Đã chạy |
| `che779-v1` (trước là `che779-remoter`; V1 + Remoter) | Đã chạy 3 tab dưới Xvfb |
| Máy Linux có màn hình + window manager | **Chưa thử** |
| Fedora/Arch/Alpine/openSUSE, Wayland | **Chưa thử** |
| Termux | Nằm ở `apps/termux/` (thẻ `termux-v*`) |
| Đã đăng Release | Khi Cherry gắn thẻ `v1.3.1` |

Phụ thuộc: ghim ở `EMULATOR_V1_REF`, `EMULATOR_V2_REF` (ở gốc repo, dùng chung cho Linux và Termux).

## Cập nhật 2026-11-28
- Có thêm `apps/termux/` (chuyển từ Che779-Android). File Linux đổi tên `che779-linux.sh`. 4 workflow: `ci-linux`, `release-linux` (thẻ `v*`), `ci-termux`, `release-termux` (thẻ `termux-v*`). Phiên bản vẫn 1.3.0 (Linux) và 1.3.0 (Termux, `apps/termux/VERSION`).
- `BUILD_VERIFIED` cục bộ: build jar, `tests/test-script.sh`, `tests/test-termux.sh`, `tests/test-packages.sh` đều đạt. `CI_VERIFIED`: chưa (đợi chạy Actions). `DEVICE_VERIFIED`: không có (Termux và Linux đều chưa thử lại trên máy thật sau thay đổi).

# Kiểm thử

- `tests/test-script.sh [thư-mục-jar]`: với cả v1 và v2: ghép `che779-linux-<v>.sh`, `bash -n`, SHA-256, tách jar, từ chối mã sai và nhãn biến thể bị đổi, `--version`, `--help`, không cần `unzip`.
- `tests/test-packages.sh`: `.tar.gz` và `.deb` của v1 và v2 đủ jar + lệnh (v2 không chứa Remoter), đúng tên gói, đúng phiên bản, phụ thuộc Java, `--version` chạy được.
- `tests/RemoterCoreTest.java`: lõi Remoter (cần Emulator V1 + game thật): `java -cp build/jars/Che779_Remoter.jar tests/RemoterCoreTest.java <Che779_Emulator.jar> <game.jar>`.

| Môi trường | Tình trạng |
|---|---|
| CI Ubuntu (build, ghép, test) | Tự động |
| Ubuntu 24.04 (Claude): cài `.deb`, lệnh V2 + game thật, Xvfb (bản trước khi đổi tên) | Đã chạy |
| `che779-v1` (trước là `che779-remoter`) 3 tab V1, Xvfb | Đã chạy với tên cũ |
| `che779-linux-v1.sh` khởi động Remoter dưới Xvfb (12 giây, chưa mở game) | Đã chạy (Claude, cục bộ) |
| Linux có màn hình + window manager, Wayland | **Chưa thử** |
| Fedora/Arch/Alpine/openSUSE, `.deb` trên Debian/Mint thật | **Chưa thử** |
| Sắp xếp tab bằng `xdotool` | **Chưa thử** |

## Termux và đổi tên (2026-11-28)
| ID | Việc | Trạng thái |
|---|---|---|
| X1 | `tests/test-termux.sh` với jar V1 và V2 ghim | BUILD_VERIFIED (cục bộ) |
| X2 | `tests/test-script.sh` (v1 và v2) | BUILD_VERIFIED (cục bộ) |
| X3 | Actions `ci-linux`, `ci-termux` | CI_VERIFIED nếu xanh (xem lần chạy) |
| X4 | Chạy `che779-termux-v2.sh` và `-v1.sh` trên Termux thật | NOT_RUN |

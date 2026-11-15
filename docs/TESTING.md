# Kiểm thử

- `tests/test-script.sh <jar V2>`: ghép `che779.sh`, `bash -n`, placeholder, SHA-256, tách jar, từ chối jar/mã sai, `--version`, `--help`, không cần `unzip`.
- `tests/test-packages.sh`: `.tar.gz` và `.deb` đủ jar + lệnh, đúng phiên bản, phụ thuộc Java, `--version` chạy được.
- `tests/RemoterCoreTest.java`: lõi Remoter (cần Emulator V1 + game thật): `java -cp build/jars/Che779_Remoter.jar tests/RemoterCoreTest.java <Che779_Emulator.jar> <game.jar>`.

| Môi trường | Tình trạng |
|---|---|
| CI Ubuntu (build, ghép, test) | Tự động |
| Ubuntu 24.04 (Claude): cài `.deb`, `che779` V2 + game thật, Xvfb | Đã chạy |
| `che779-remoter` 3 tab V1, Xvfb | Đã chạy |
| Linux có màn hình + window manager, Wayland | **Chưa thử** |
| Fedora/Arch/Alpine/openSUSE, `.deb` trên Debian/Mint thật | **Chưa thử** |
| Sắp xếp tab bằng `xdotool` | **Chưa thử** |

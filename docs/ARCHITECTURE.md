# Kiến trúc

```
apps/linux/
├── che779.sh            bản nguồn script một file (placeholder @VERSION@, @JAR_SHA256@)
├── packaging/           lệnh che779, che779-remoter và 2 tệp .desktop
├── remoter-linux/       mã Remoter Linux (Java/Swing): Main, Core, Ipc
└── EMULATOR_V1_REF / EMULATOR_V2_REF   commit ghim của Che779-Emulator / Che779-EmulatorV2
scripts/                 fetch-sources → build-jars → package-tar / package-deb / build-release
```

## Luồng phát hành
1. `fetch-sources.sh`: clone Che779-Emulator (V1) và Che779-EmulatorV2 (V2) đúng commit ghim.
2. `build-jars.sh`: V1/V2 build bằng `.github/scripts/build-*.sh` của chính repo đó; Remoter Linux bằng `apps/linux/remoter-linux/build.sh` → `build/jars/{Che779_Emulator,Che779_EmulatorV2,Che779_Remoter}.jar`.
3. `package-tar.sh` → `che779-<ver>-linux.tar.gz` (lệnh + `lib/*.jar`); `package-deb.sh` → `che779_<ver>_all.deb` (lệnh ở `/usr/bin`, jar ở `/usr/share/che779`, phụ thuộc Java); `build-release.sh` → `che779.sh` (V2 nhúng base64, SHA-256 điền từ chính jar).
4. Actions tạo `SHA256SUMS.txt` **sau cùng** trên các file đăng.

## Lệnh
- `che779` chạy `java -jar Che779_EmulatorV2.jar` (RAM `-r`, game ở `~/Che779Games`, màn hình ảo Xvfb nếu không có DISPLAY).
- `che779-remoter` chạy Remoter; Remoter tìm `Che779_Emulator.jar` cạnh nó và mở mỗi game một tiến trình, nói chuyện qua IPC TCP 127.0.0.1 (xem docs của Che779-Emulator).

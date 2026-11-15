# Kiến trúc

```
che779.sh (một file)
├── phần script bash  (apps/linux/che779.sh, có placeholder)
└── sau dòng __JAR__  : jar EmulatorV2 mã hoá base64
```

## Luồng chạy
1. Đọc tuỳ chọn (`-r`, `-g`, `--net`, `--doctor`, `--reset`, `-V`, `-h`; kiểu cũ `bash che779.sh 1024 build11`).
2. Nhận diện môi trường: **Termux** (có `$PREFIX`/`com.termux`) hoặc **Linux** (đọc `/etc/os-release`).
3. **Linux:** kiểm tra `java`; thiếu → cài gói OpenJDK chính thức bằng trình quản lý gói của distro (`apt`, `dnf`, `pacman`, `apk`, `zypper`); không có màn hình → dùng `xvfb`.
4. **Termux:** cài `proot-distro` + Ubuntu, Java, Openbox, Termux:X11, rồi chạy bên trong proot.
5. Tách jar: kiểm tra đầu tệp ZIP (`504b0304`) và SHA-256 so với mã điền lúc đóng gói; sai → dừng.
6. Chạy `java -jar` với RAM/game theo tuỳ chọn.

## Dữ liệu
| Môi trường | Dữ liệu | Game |
|---|---|---|
| Linux | `~/.che779` | `~/Che779Games` |
| Termux | `Download/Che779Data` | `Download/Che779Games` |

## Đóng gói
`scripts/build-release.sh <jar> <thư-mục-ra>`: tính SHA-256 từ jar → thay `@VERSION@`, `@JAR_SHA256@` bằng `sed` → nối `base64` jar sau `__JAR__` → `bash -n` kiểm cú pháp.

# Che779 Linux / Termux — Emulator V2 trong một file

Chạy game Java (J2ME) trên **Linux** và **Termux (Android)** chỉ với **một file `che779.sh`**. Jar Che779 EmulatorV2 đã nhúng sẵn; script tự lo Java bằng gói chính thức của distro.

## Mục lục
1. Điểm nổi bật · 2. Tải về · 3. Cách dùng · 4. Tuỳ chọn · 5. Linux · 6. Termux · 7. Dữ liệu · 8. Toàn vẹn & bảo mật · 9. Tự build · 10. Cấu trúc repo · 11. Tài liệu · 12. Đã thử / chưa thử · 13. Đóng góp · 14. Giấy phép

## 1. Điểm nổi bật
- Một file duy nhất, không cần `unzip`, không tải/giải nén tay.
- Tự nhận diện Linux (Debian/Ubuntu/Mint, Fedora/RHEL, Arch/Manjaro, Alpine, openSUSE, WSL) hoặc Termux.
- Thiếu Java → cài OpenJDK **chính thức** của distro (cần `sudo`).
- Kiểm tra jar bằng đầu tệp ZIP và **SHA-256**; sai thì từ chối chạy.
- Terminal có màu, khung, vòng quay chờ, bảng thông tin môi trường; lệnh `--doctor` chẩn đoán và `--net` kiểm tra mạng.

## 2. Tải về
Vào mục **Releases**, tải `che779.sh` và `SHA256SUMS.txt`:

```bash
sha256sum -c SHA256SUMS.txt
```

## 3. Cách dùng
```bash
bash che779.sh                 # chạy mặc định
bash che779.sh -r 1024         # cấp 1024 MB RAM
bash che779.sh -g build11      # chọn game
bash che779.sh --doctor        # chẩn đoán môi trường
```

## 4. Tuỳ chọn
| Tuỳ chọn | Ý nghĩa |
|---|---|
| `-r`, `--ram MB` | RAM tối đa cho Java (mặc định 1024) |
| `-g`, `--game TEXT` | Tự mở các game trong kho có tên chứa TEXT |
| `--net` | Kiểm tra mạng (DNS, HTTP, cổng game) rồi thoát |
| `--doctor` | In thông tin môi trường rồi thoát |
| `--reset` | Cài lại từ đầu (xoá dấu hiệu "đã cài") |
| `-V`, `--version` | Hiện phiên bản |
| `-h`, `--help` | Trợ giúp |

Kiểu cũ `bash che779.sh 1024 build11` vẫn dùng được.

## 5. Linux
Cần `bash`, `base64`, `sha256sum` (hoặc `shasum`/`openssl`) và quyền `sudo` nếu phải cài Java/Xvfb. Máy không có màn hình sẽ dùng Xvfb. Chi tiết: `docs/ARCHITECTURE.md`.

## 6. Termux
Script cài `proot-distro` + Ubuntu, Java, Openbox và Termux:X11 rồi mở emulator. **Chủ dự án đã thử: chạy được và chơi được game.** Cần cài sẵn app Termux:X11.

## 7. Dữ liệu
| Môi trường | Dữ liệu | Game |
|---|---|---|
| Linux | `~/.che779` | `~/Che779Games` |
| Termux | `Download/Che779Data` | `Download/Che779Games` |

## 8. Toàn vẹn & bảo mật
Xem `SECURITY.md`. Hãy đọc script trước khi chạy nếu không tin nguồn tải; chỉ tải từ Releases chính thức.

## 9. Tự build
Xem `docs/BUILD_AND_RUN.md`. Phát hành: `git tag v1.2.0 && git push origin v1.2.0`.

## 10. Cấu trúc repo
```
Che779-Linux/
├── apps/linux/           # che779.sh (nguồn), EMULATOR_V2_REF
├── scripts/              # build-release.sh
├── tests/                # test-script.sh
├── docs/                 # tài liệu
├── .github/              # workflows, mẫu issue/PR
├── VERSION  CHANGELOG.md  CONTRIBUTING.md  SECURITY.md  LICENSE
└── THIRD_PARTY_NOTICES.md
```

## 11. Tài liệu
Mục lục tại [`docs/README.md`](docs/README.md).

## 12. Đã thử / chưa thử
- **Đã thử:** Termux thật (chủ dự án); ghép + kiểm thử script cục bộ và trên CI.
- **Chưa thử:** cài tự động trên Fedora, Arch, Alpine, openSUSE; WSL; Remoter Linux với WM/Wayland thật.

## 13. Đóng góp
Xem `CONTRIBUTING.md`.

## 14. Giấy phép
Xem `LICENSE`; thành phần bên thứ ba ở `THIRD_PARTY_NOTICES.md`.

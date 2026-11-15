# Che779 Linux — giả lập game Java (J2ME) cho Linux

> **Nền tảng: Linux.** Quy ước 4 repo: **P1 và P2 = Windows · P3 = Linux · P4 = Android (kèm Termux)**. Repo này là bản Linux của Che779 Emulator V1 + Remoter và V2. Termux (Android) nằm ở [Che779-Android](https://github.com/Kidtomboy/Che779-Android).

Cài một gói `.deb` (hoặc giải nén `.tar.gz`) rồi chạy `che779` để mở **Emulator V2** (nhiều tab trong một cửa sổ), hoặc `che779-remoter` để dùng **Emulator V1 + Remoter** (mỗi tab một cửa sổ, điều khiển tập trung).

## Mục lục
1. [Tải về](#1-tải-về) · 2. [Cài và chạy](#2-cài-và-chạy) · 3. [Hai chương trình](#3-hai-chương-trình) · 4. [Yêu cầu](#4-yêu-cầu) · 5. [Remoter Linux](#5-remoter-linux) · 6. [Dữ liệu](#6-dữ-liệu) · 7. [Kiểm tra file tải về](#7-kiểm-tra-file-tải-về) · 8. [Tự build](#8-tự-build) · 9. [Cấu trúc repo](#9-cấu-trúc-repo) · 10. [Đã thử / chưa thử](#10-đã-thử--chưa-thử) · 11. [Hỏi đáp](#11-hỏi-đáp) · 12. [4 repo Che779](#12-4-repo-che779) · 13. [Tài liệu, đóng góp, giấy phép](#13-tài-liệu-đóng-góp-giấy-phép)

## 1. Tải về
Vào mục **Releases** và chọn một trong ba cách:

| File | Dùng khi | Ghi chú |
|---|---|---|
| `che779_<phiên bản>_all.deb` | Ubuntu, Linux Mint, Debian và bản phái sinh | **Khuyên dùng.** `apt` tự cài Java chính thức nếu thiếu |
| `che779-<phiên bản>-linux.tar.gz` | Mọi distro | Giải nén là chạy; cần tự có Java |
| `che779.sh` | Mọi distro, chỉ cần V2 | Một file có sẵn V2 bên trong; giữ tạm |

Mỗi bản phát hành có kèm `SHA256SUMS.txt` (xem [mục 7](#7-kiểm-tra-file-tải-về)).

## 2. Cài và chạy
**Gói `.deb`** (Ubuntu/Mint/Debian):
```bash
sudo apt install ./che779_1.3.0_all.deb
che779                 # Emulator V2
che779-remoter         # Emulator V1 + Remoter
```
**Gói `.tar.gz`** (mọi distro):
```bash
tar xzf che779-1.3.0-linux.tar.gz && cd che779-1.3.0-linux
./che779               # hoặc ./che779-remoter
```
**Một file `che779.sh`:** `bash che779.sh` (chạy V2; script tự cài Java bằng gói chính thức của distro nếu thiếu, cần `sudo`).

Chọn RAM: `che779 -r 2048` (MB). Mở sẵn game: `che779 /đường/dẫn/game.jar`.

## 3. Hai chương trình
| Lệnh | Là gì | Dùng khi |
|---|---|---|
| `che779` | **Emulator V2**: mọi tab trong một cửa sổ, một tiến trình | Nhẹ, gọn; nhiều tab |
| `che779-remoter` | **Emulator V1 + Remoter Linux**: mỗi game một cửa sổ riêng, Remoter điều khiển tất cả | Một game treo không kéo sập game khác; tốn RAM hơn |

## 4. Yêu cầu
- Linux có **Java 8 trở lên** (gói `.deb` tự yêu cầu Java chính thức) và **màn hình đồ họa** (X11 hoặc Wayland). Không có màn hình (SSH/máy chủ): cài `xvfb`, lệnh sẽ tự dùng màn hình ảo (không thấy cửa sổ).
- Sắp xếp cửa sổ trong Remoter cần `xdotool` (X11). Gói `.deb` chỉ *đề xuất* gói này.

## 5. Remoter Linux
Giao diện 6 khu vực bám Remoter Windows (đường dẫn, cấu hình tab/lưới, hành động, danh sách tab với CPU/RAM/PID, đồng bộ & bàn phím, tiện ích; hồ sơ, tự mở lại, hẹn giờ…). Bảng đối chiếu Windows ↔ Linux và chức năng chưa làm (Xem lưới, Macro): [`apps/linux/remoter-linux/README.md`](apps/linux/remoter-linux/README.md).

## 6. Dữ liệu
| Chương trình | Dữ liệu | Game |
|---|---|---|
| V2 (`che779`) | `~/.che779` | `~/Che779Games` |
| Remoter (`che779-remoter`) | `~/.che779/Che779-Remoter` (cấu hình), `~/.che779/Che779-Emulator` (Emulator V1) | chọn trong Remoter |

## 7. Kiểm tra file tải về
```bash
sha256sum -c SHA256SUMS.txt
```
Mã SHA-256 được tính **sau cùng** trên đúng các file đăng ở Releases. Riêng `che779.sh` còn tự kiểm tra jar nhúng (đầu tệp ZIP + SHA-256 ghi lúc đóng gói) và từ chối chạy nếu sai.

## 8. Tự build
Cần `git`, JDK 8+ (và `dpkg-deb` để làm `.deb`):
```bash
bash scripts/fetch-sources.sh      # lấy mã V1, V2 đúng commit đã ghim (apps/linux/EMULATOR_V*_REF)
bash scripts/build-jars.sh         # build 3 jar vào build/jars
bash scripts/package-tar.sh        # dist/che779-<ver>-linux.tar.gz
bash scripts/package-deb.sh        # dist/che779_<ver>_all.deb
bash scripts/build-release.sh build/jars/Che779_EmulatorV2.jar   # dist/che779.sh
```
Phát hành: Cherry gắn thẻ `v1.3.0` → GitHub Actions build và đăng file + `SHA256SUMS.txt`. Chi tiết: [`docs/BUILD_AND_RUN.md`](docs/BUILD_AND_RUN.md).

## 9. Cấu trúc repo
```
Che779-Linux/
├── apps/linux/            che779.sh (nguồn), packaging/ (lệnh, .desktop), remoter-linux/ (mã Remoter), EMULATOR_V1_REF, EMULATOR_V2_REF
├── scripts/               fetch-sources, build-jars, package-tar, package-deb, build-release
├── tests/                 test-script.sh, test-packages.sh, RemoterCoreTest.java
├── docs/                  tài liệu
├── .github/               workflow CI + Phát hành, mẫu issue/PR
└── VERSION  CHANGELOG.md  CONTRIBUTING.md  SECURITY.md  LICENSE  THIRD_PARTY_NOTICES.md
```
Mã Emulator V1/V2 **không chép** vào đây: Actions lấy từ Che779-Emulator / Che779-EmulatorV2 đúng commit đã ghim.

## 10. Đã thử / chưa thử
- **Đã thử (Claude, Ubuntu 24.04, JDK 21, màn hình ảo Xvfb):** build 3 jar; tạo `.deb` + `.tar.gz`; cài `.deb`; `che779` chạy V2 với game thật; ghép và kiểm thử `che779.sh`; Remoter Linux mở 3 tab với V1 (xem README Remoter).
- **Chưa thử:** máy Linux có màn hình thật và trình quản lý cửa sổ; Wayland; Fedora/Arch/Alpine/openSUSE (`che779.sh` cài Java tự động); Sắp xếp tab bằng `xdotool`; `.deb` trên Debian/Mint thật.

## 11. Hỏi đáp
| Gặp | Làm |
|---|---|
| `che779: không có màn hình` | Chạy trong desktop, hoặc `sudo apt install xvfb` |
| Thiếu Java | `sudo apt install default-jre` (gói `.deb` tự cài) |
| Remoter không sắp xếp được cửa sổ | `sudo apt install xdotool`; Wayland thuần chưa hỗ trợ |
| Muốn báo lỗi | Mở Issue, ghi `che779 --version` và `bash che779.sh --doctor` nếu có |

## 12. 4 repo Che779
| # | Repo | Nền tảng |
|:-:|---|---|
| 1 | [Che779-Emulator](https://github.com/Kidtomboy/Che779-Emulator) | Windows (V1 + Remoter) |
| 2 | [Che779-EmulatorV2](https://github.com/Kidtomboy/Che779-EmulatorV2) | Windows (V2) |
| 3 | **Che779-Linux** ← bạn đang ở đây | Linux |
| 4 | [Che779-Android](https://github.com/Kidtomboy/Che779-Android) | Android (APK; Termux chạy V2) |

## 13. Tài liệu, đóng góp, giấy phép
Mục lục tài liệu: [`docs/README.md`](docs/README.md). Đóng góp: [`CONTRIBUTING.md`](CONTRIBUTING.md). Bảo mật: [`SECURITY.md`](SECURITY.md). Giấy phép: [`LICENSE`](LICENSE); bên thứ ba: [`THIRD_PARTY_NOTICES.md`](THIRD_PARTY_NOTICES.md).

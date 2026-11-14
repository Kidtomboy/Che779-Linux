<div align="center">

# 🐧 Che779 Linux & Termux

**Chạy Che779 Emulator V2 trên Linux và trên Android (Termux) chỉ bằng một lệnh.**

Một tệp `che779.sh` tự nhận diện hệ điều hành, kiểm tra môi trường, cài phần còn thiếu và mở emulator.

[![Linux](https://img.shields.io/badge/Linux-apt%20%C2%B7%20dnf%20%C2%B7%20pacman%20%C2%B7%20apk%20%C2%B7%20zypper-FCC624?logo=linux&logoColor=black)](#-linux)
[![Termux](https://img.shields.io/badge/Android-Termux-3DDC84?logo=android&logoColor=white)](#-termux-android)
[![Giấy phép](https://img.shields.io/badge/giấy%20phép-Apache%202.0-orange)](LICENSE)
[![Trạng thái](https://img.shields.io/badge/trạng%20thái-thử%20nghiệm-yellow)](#-trạng-thái-và-giới-hạn)

[Bắt đầu nhanh](#-bắt-đầu-nhanh) · [Tùy chọn](#-tùy-chọn-dòng-lệnh) · [Linux](#-linux) · [Termux](#-termux-android) · [Lộ trình](#-lộ-trình) · [Tài liệu](#-tài-liệu) · [Ghi công](#-ghi-công-và-giấy-phép)

</div>

---

## 🌐 Hệ sinh thái Che779

Che779 gồm 4 dự án, mỗi dự án một repo. Bạn đang xem **Project 3**.

| # | Dự án | Chạy trên | Dùng khi nào |
|:-:|---|---|---|
| 1 | [**Che779-Emulator**](https://github.com/Kidtomboy/Che779-Emulator) | Windows | Mỗi tab một cửa sổ, điều khiển bằng Remoter |
| 2 | [**Che779-EmulatorV2**](https://github.com/Kidtomboy/Che779-EmulatorV2) | Windows / Java 8+ | Nhiều tab trong một cửa sổ, một tiến trình |
| 3 | **Che779-Linux** ← *bạn đang ở đây* | Linux và Termux | Gói chạy trên Linux và Android (Termux) |
| 4 | [**Che779-Android**](https://github.com/Kidtomboy/Che779-Android) | Android | Chạy trực tiếp trên điện thoại bằng APK |

Gói này đóng gói **Che779 Emulator V2** (Project 2) cho Linux và Termux. Nó không phải một emulator riêng.

---

## ⚡ Bắt đầu nhanh

```bash
bash che779.sh
```

Script sẽ:

1. 🔍 nhận diện hệ điều hành (Linux, Termux, WSL) và kiểu quản lý gói;
2. 🩺 hiện bảng thông tin máy: kiến trúc, RAM trống, Java, màn hình;
3. 📦 cài phần còn thiếu (Java trên Linux; Ubuntu + Java + Openbox + Termux:X11 trên Termux);
4. 🚀 giải nén emulator đóng sẵn trong tệp và mở lên, kèm các game bạn chọn.

Mỗi bước có vòng quay chờ, dấu ✔ / ✘ / ▲ và màu; lỗi thì in đuôi nhật ký để bạn biết vì sao.

---

## 🎛️ Tùy chọn dòng lệnh

| Tùy chọn | Tác dụng |
|---|---|
| `-r`, `--ram MB` | RAM tối đa cho Java (mặc định 1024, tối thiểu 128) |
| `-g`, `--game TEXT` | Tự mở các game trong kho có tên chứa `TEXT` |
| `--net` | Kiểm tra mạng: phân giải tên miền, tải danh sách máy chủ game, thử mở từng cổng |
| `--doctor` | In thông tin môi trường rồi thoát |
| `--reset` | Cài lại từ đầu (Termux) |
| `-h`, `--help` | Trợ giúp |

Kiểu cũ vẫn dùng được: `bash che779.sh 1024 build11` (RAM, rồi tên game).

> 💡 Game chạy không vào được mạng? Chạy `bash che779.sh --net` trước để biết mạng, DNS hay cổng game đang bị chặn.

---

## 🐧 Linux

| | |
|---|---|
| Hệ điều hành | Debian/Ubuntu (apt), Fedora/RHEL (dnf), Arch (pacman), Alpine (apk), openSUSE (zypper) |
| Cần có | Java 8+, màn hình đồ họa (X11 hoặc Wayland). Thiếu Java thì script tự cài (cần `sudo`) |
| Không có màn hình | Nếu máy có `xvfb-run`, script dùng màn hình ảo — chạy được nhưng **không nhìn thấy cửa sổ** |
| Kho game | `~/Che779Games` — bỏ file `.jar` vào đây |
| Dữ liệu | `~/.che779` — `acc.txt` ở `~/.che779/filesystem/c/AngelChip/acc.txt` (game thấy `file:///c/AngelChip/acc.txt`) |

---

## 📱 Termux (Android)

Lần đầu cần mạng và khoảng 5–10 phút. Script cài Ubuntu bằng `proot-distro`, Java, Openbox và Termux:X11, rồi mở emulator trên màn hình ảo.

| | |
|---|---|
| Cần cài thêm | App **Termux:X11** (tải APK ở [termux-x11/releases](https://github.com/termux/termux-x11/releases)) — một lần |
| Kho game | `Download/Che779Games` |
| Dữ liệu | `Download/Che779Data` — `acc.txt` ở `Download/Che779Data/filesystem/c/AngelChip/acc.txt` |
| Tiết kiệm RAM | Java chạy với tuỳ chọn gọn (`-Xmx`, SerialGC, `TieredStopAtLevel=1`, ...) |
| Kết thúc | Thoát emulator thì script tự nhả khóa thức (wake lock) |

---

## 🧭 Trạng thái và giới hạn

Đây là **bản thử nghiệm**, chưa phải bản phát hành. Mình ghi rõ cái gì đã thử, cái gì chưa:

| Hạng mục | Tình trạng |
|---|---|
| Cú pháp script, giải nén và kiểm tra jar nhúng | ✅ đã kiểm tra |
| Nhận diện Linux (Ubuntu 24.04) và hiện bảng môi trường | ✅ đã thử |
| Mở emulator trên Linux với màn hình ảo, nạp game thật | ✅ đã thử |
| Nhận diện Termux | ⚠️ chỉ giả lập bằng biến môi trường, chưa thử trên Android thật |
| Cài đặt Termux / proot / Termux:X11 thật | ❌ chưa thử |
| Tự cài Java trên Fedora, Arch, Alpine, openSUSE | ❌ chưa thử (mới viết lệnh) |
| Chạy game có mạng thật tới máy chủ | ❌ chưa kiểm chứng (môi trường thử bị chặn mạng) |

Các vấn đề đã biết trước khi phát hành chính thức:

1. Jar nhúng **chưa trùng hoàn toàn** với jar Project 2 mới nhất; cần ghim phiên bản và mã băm.
2. Trên Termux, script xóa và tạo lại thư mục bản sao game (`~/che779_share/games`) mỗi lần chạy — chỉ là bản sao, kho game gốc không bị đụng, nhưng sẽ được đổi sang cách đồng bộ an toàn hơn.
3. Chưa kiểm tra X11 đã sẵn sàng trước khi mở Java, nên có thể chạy mà không thấy cửa sổ.
4. Danh sách máy chủ dùng HTTP thường, chưa có kiểm tra toàn vẹn.

---

## 🗺️ Lộ trình

- [ ] **Chốt nguồn:** ghim jar Project 2 chuẩn kèm SHA-256.
- [ ] **Dọn script:** thêm exit code đúng cho `--net`, đồng bộ game an toàn, kiểm tra X11.
- [ ] **Gói chạy offline:** tải một lần, chạy nhiều lần, dữ liệu tách khỏi phần chương trình.
- [ ] **Termux thật:** kiểm thử trên thiết bị Android.
- [ ] **Chế độ nhiều cửa sổ (V1 + Remoter chạy trên Linux):** gói thêm Emulator V1 của [Project 1](https://github.com/Kidtomboy/Che779-Emulator) và một Remoter viết lại bằng Java để dùng được cả trên Linux. *Đang lên kế hoạch, chưa có bản chạy.*
- [ ] **Ảnh OCI (Docker/Podman)** cho Linux — tùy chọn.

Chi tiết từng giai đoạn: [`docs/ROADMAP.md`](docs/ROADMAP.md).

---

## 📚 Tài liệu

[Kiến trúc](docs/ARCHITECTURE.md) · [Quyết định phân phối](docs/ADR-001-DISTRIBUTION.md) · [Lộ trình](docs/ROADMAP.md) · [Ma trận kiểm thử](docs/TEST-MATRIX.md) · [Bảo mật và an toàn dữ liệu](docs/SECURITY-AND-DATA-SAFETY.md) · [Đặc tả manifest phát hành](docs/RELEASE-MANIFEST-SPEC.md) · [Bàn giao](docs/AI-HANDOFF.md)

---

## 🙏 Ghi công và giấy phép

Gói này chứa Che779 Emulator V2, dựa trên **[MicroEmulator](https://github.com/barteo/microemu)** 3.0.0 (Apache License 2.0). Giữ nguyên thông báo bản quyền khi phân phối lại; xem [`LICENSE`](LICENSE) và `THIRD_PARTY_NOTICES.md` của [Che779-EmulatorV2](https://github.com/Kidtomboy/Che779-EmulatorV2).

<div align="center">

Làm bởi **Cherry** · [Báo lỗi](../../issues)

</div>

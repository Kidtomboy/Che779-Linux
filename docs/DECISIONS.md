# Quyết định thiết kế

## ✅ QUYẾT ĐỊNH CỦA CHERRY — 2026-11-16 (hiệu lực, thay thế mọi mục cũ bên dưới)

Cả 4 repo lên **v1.3.0 thẳng** (không tạo tag v1.2.0). Phân chia: **P1, P2 = Windows** (chỉ mã nguồn + script build `.bat/.cmd/.ps1`, Actions tự build); **P3 = Linux** (V2 + V1 + Remoter Linux; `.deb` + `.tar.gz`; `.sh` giữ tạm); **P4 = Android** (APK + APK clone; `termux/` chỉ V2, V1 ở `termux/test/`). P3/P4 **không chép mã Emulator**, chỉ ghim commit P1/P2 (`EMULATOR_V1_REF`, `EMULATOR_V2_REF`). Mọi Release có `SHA256SUMS.txt` tính sau cùng. Giữ nguyên tên repo. Các mục "tag v1.2.0 trước" ở dưới là **đã bị thay thế**.


1. **Một file duy nhất.** Người dùng chỉ tải `che779-linux.sh`; jar nhúng sẵn bằng base64 sau `__JAR__`.
2. **Gói chính thức của distro** cho Java/Xvfb, không tải tay, không giải nén tay.
3. **SHA-256 tính sau cùng** từ jar thật, bằng `build-release.sh`; không điền tay.
4. **Ghim V2 bằng commit** (`EMULATOR_V2_REF`) để bản phát hành tái lập được.
5. **Gỡ `che779-linux.sh` 1,2 MB khỏi gốc repo**: bản chạy được chỉ có ở Releases (tránh nhúng file nhị phân vào git).
6. **Phiên bản 1.2.0**, đồng bộ với 3 repo còn lại; CHANGELOG chỉ ghi bản hiện tại.
7. **Không bó Remoter Java** vào script ở bản này.

## Quyết định 15/11/2026: chia lại 4 repo theo nền tảng (thực hiện ở 1.3.0)
Do Cherry quyết, Claude ghi lại. Áp dụng cho cả 4 repo; Claude và Darling không làm ngược lại khi chưa hỏi Cherry.

**Câu nhớ:** *1 và 2 = Windows · 3 = Linux · 4 = Android (kèm Termux).*

| Repo | Nền tảng | Chứa | Phát hành (GitHub Actions tự build) |
|---|---|---|---|
| P1 Che779-Emulator | Windows | Mã V1 + Remoter Windows (C#), file build `.bat/.cmd/.ps1`, docs, test | zip Windows |
| P2 Che779-EmulatorV2 | Windows | Mã V2, file build `.bat/.cmd/.ps1`, docs, test | zip Windows |
| P3 Che779-Linux | Linux (bỏ Termux) | Script/gói Linux, **Remoter Linux** (chuyển từ P1), docs, test; bản Linux của V1 và V2 | `.deb`, `.tar.gz` (giữ `che779-linux.sh` tạm đến khi hai cái này ổn); `.rpm` để sau |
| P4 Che779-Android | Android + Termux | Mã APK (Gradle) + bản clone; thư mục `termux/` (script Termux chuyển từ P3, **chỉ V2**) | APK, APK clone, `che779-termux.sh` |

**Quy tắc kèm theo**
1. **Mã Java Emulator chỉ có một chỗ:** V1 ở P1, V2 ở P2. P3 và P4 **không chép mã**, chỉ **ghim commit** (file `EMULATOR_V1_REF` / `EMULATOR_V2_REF`) và Actions kéo về build.
2. Termux chỉ chạy **V2** (Cherry thấy Termux khó thao tác). **V1 cho Termux** để trong thư mục `test/` của P4 cho ai muốn trải nghiệm, không cam kết.
3. Gói Linux dùng **gói chính thức của distro** cho Java; `.deb` khai báo phụ thuộc Java thay vì tải tay. Không làm AppImage/Flatpak/Snap (quá phức tạp).
4. Mọi README mở đầu bằng dòng "Nền tảng: …" và cùng một bảng 4 repo.
5. **Giữ nguyên tên repo** (đổi tên làm hỏng link cũ).
6. **Thứ tự:** (a) ~~tag v1.2.0~~ (bị thay thế: lên thẳng 1.3.0); (b) hoàn thiện Remoter Linux ở P1 (Xem lưới; Cherry/Darling thử bản Linux thật); (c) bản **1.3.0** mới chia lại: chuyển Remoter Linux sang P3, thêm `.deb`/`.tar.gz`, tách Termux sang P4 (`termux/`), dọn P1/P3, sửa README/docs/workflow, cập nhật `che779-projects`.
7. Phiên bản và mọi quy ước 1.2.0 (tiếng Việt, CHANGELOG chỉ ghi bản hiện tại, SHA256SUMS tính sau cùng trên file cuối, ghi rõ đã/chưa thử) vẫn áp dụng.

## Quyết định của Cherry (15/11/2026): chia repo theo nền tảng — áp dụng từ bản 1.3.0

**Câu để nhớ: P1 và P2 = Windows · P3 = Linux · P4 = Android (kèm Termux).**

| Repo | Nền tảng | Chứa | Cách ra file cho người dùng |
|---|---|---|---|
| P1 Che779-Emulator | Windows | Mã nguồn V1 + Remoter Windows, file build `.bat/.cmd/.ps1` | GitHub Actions build, đóng zip + `SHA256SUMS.txt` |
| P2 Che779-EmulatorV2 | Windows | Mã nguồn V2, file build `.bat/.cmd/.ps1` | Như trên |
| P3 Che779-Linux | Linux (bỏ Termux) | Mã riêng: script, Remoter Linux; V1/V2 build từ P1/P2 | Actions tạo `.deb` + `.tar.gz` (+ `.sh` giữ tạm) + `SHA256SUMS.txt` |
| P4 Che779-Android | Android | Gradle/APK, bản clone, thư mục `termux/` (chỉ V2) | Actions tạo APK, APK clone, `che779-termux.sh` + `SHA256SUMS.txt` |

1. **Không chép mã Emulator V1/V2 sang repo khác.** P3 và P4 ghim commit của P1/P2 (như `apps/linux/EMULATOR_V2_REF`) rồi build trong Actions.
2. **Remoter Linux chuyển từ P1 sang P3** (ghim V1 từ P1). P1 chỉ còn Windows.
3. **Termux chỉ chạy V2**, nằm ở P4 (`termux/`). V1 cho ai muốn thử đặt ở thư mục `test/` (không hỗ trợ chính thức). P3 bỏ Termux.
4. **Linux đóng gói:** `.deb` (Ubuntu/Mint/Debian, phụ thuộc gói Java chính thức) + `.tar.gz` chạy ngay; `.rpm` để sau; **không** AppImage/Flatpak/Snap. `.sh` một file giữ đến khi hai cách trên ổn.
5. **`SHA256SUMS.txt` có ở mọi bản phát hành của cả 4 repo**, tính SAU CÙNG trên đúng các file sẽ đăng.
6. **Thứ tự:** (a) ~~tag v1.2.0~~ (bị thay thế: lên thẳng 1.3.0); (b) hoàn thiện Remoter Linux (Xem lưới) và nhờ chạy thử Linux thật; (c) 1.3.0 mới chia lại. Không đổi tên repo.
7. Mỗi README bắt đầu bằng dòng "Nền tảng: …" và bảng 4 repo giống nhau; mô tả repo trên GitHub ghi dạng "[Windows] …", "[Linux] …", "[Android] …".

- **Việc của repo này ở 1.3.0:** thêm `scripts/build-deb.sh`, `scripts/build-tar.sh`; nhận Remoter Linux từ P1; build V1+V2 từ commit ghim (thêm `apps/linux/EMULATOR_V1_REF`); bỏ nhánh Termux khỏi `che779-linux.sh` (chuyển sang P4); workflow Phát hành tạo `.deb`, `.tar.gz`, `.sh`, `SHA256SUMS.txt`.

## 2026-11-28 — Termux về lại Che779-Linux
- **Quyết định (Cherry):** chuyển Termux từ Che779-Android (`termux/`) về Che779-Linux (`apps/termux/`). Lý do: ít người dùng, cập nhật theo nhịp riêng, và để Actions của Che779-Android chỉ còn bản chính, bản clone, bản V2 và file checksum.
- **Tách phiên bản:** `che779-linux.sh` (máy tính) và `che779-termux.sh` (Android) là hai file; workflow và thẻ riêng (`v*` cho Linux, `termux-v*` cho Termux); `apps/termux/VERSION` riêng. Chưa nâng phiên bản nào.

## 2026-11-28 — Nâng P3 lên 1.3.1
- **Quyết định (Cherry):** P3 lên 1.3.1 (Linux và Termux cùng số, `VERSION` và `apps/termux/VERSION` riêng). Ghim lại P1 `833ad6e` và P2 `ef98850` (bản 1.3.1). P1 và P2 sẽ có bản nâng cấp riêng sau, P3 theo sau khi đó.

## 2026-11-28 — Tách V1 và V2 cho Linux và Termux
- **Quyết định (Cherry):** Linux và Termux đều chạy riêng được Che779-Emulator (V1) và Che779-EmulatorV2 (V2). Mọi file `.sh`, `.tar.gz`, `.deb` có `-v1` hoặc `-v2` trong tên "để tránh thiếu sót về sau".
- **Cách làm:** (1) tên: `che779-linux-v1.sh`/`-v2.sh`, `che779-termux-v1.sh`/`-v2.sh`, `che779-v1-<ver>-linux.tar.gz`/`che779-v2-...`, `che779-v1_<ver>_all.deb`/`che779-v2_...`; (2) hai gói `.deb` độc lập (cài song song được, thư mục `/usr/share/che779-v1`, `-v2`), lệnh `che779-v1` và `che779-v2`; lệnh cũ `che779`/`che779-remoter` bỏ; (3) V1 trên Linux = Emulator V1 + Remoter Linux (script v1 nhúng tar.gz hai jar); (4) V1 trên Termux = chỉ Emulator V1 (mỗi game một tiến trình), không có Remoter; (5) cả hai nằm ở Releases (V1 Termux không còn là artifact thử nghiệm); (6) `VERSION` giữ 1.3.1 (không nâng).
- **Hệ quả:** tên file ở Release thay đổi, nên Cherry cần tạo lại thẻ `v1.3.1` và `termux-v1.3.1` ở commit mới nhất của main.

## 2026-11-28 — Quy tắc đồng bộ giữa 4 repo (Cherry, 2026-11-28)
- **P1 hoặc P2 có bản cập nhật → P3 phải theo ngay:** đổi `EMULATOR_V1_REF` / `EMULATOR_V2_REF` ở Che779-Linux sang commit mới, chạy test, cập nhật CHANGELOG/docs của P3. Nhật ký build của P3 có dòng "ghim … CHƯA theo kịp" khi P3 chậm hơn main của P1/P2.
- **P4 bản chính có cập nhật → bản clone cũng có** (CI main và Release `v*` build cả hai). **Bản V2 (`dev-*`) chỉ làm khi Cherry yêu cầu.**
- Termux nằm ở P3 (`apps/termux/`), không còn ở P4.
- **Nhật ký build:** P1, P2, P3 (Linux và Termux riêng), P4 đều đăng log lên Release tiền-phát-hành tên `buildlog` (P3: `buildlog-linux`, `buildlog-termux`) sau mỗi lần push vào main; xem ở trang Releases.

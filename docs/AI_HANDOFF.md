# Bàn giao cho AI / người tiếp quản

## Dự án là gì
Che779 Linux / Termux = **một file `che779.sh`** chạy Che779 EmulatorV2 (game J2ME) trên Linux và Termux (Android). Không có mã Java ở repo này; jar V2 được lấy từ repo [Che779-EmulatorV2](https://github.com/Kidtomboy/Che779-EmulatorV2) theo commit ghim trong `apps/linux/EMULATOR_V2_REF`.

## Việc cần nhớ
- Sửa **`apps/linux/che779.sh`** (bản nguồn, có `@VERSION@`, `@JAR_SHA256@`). Không sửa bản trong `dist/`/`out/`.
- Mã SHA-256 do `scripts/build-release.sh` tính **sau cùng** từ jar. Không bao giờ điền tay.
- Chạy `bash tests/test-script.sh <jar>` trước khi commit.
- Tài liệu và thông báo cho người dùng viết **tiếng Việt**. Phiên bản hiện tại: xem `VERSION`.
- Chỉ ghi "đã kiểm tra" khi thật sự đã chạy; xem `docs/TESTING.md` để biết cái gì đã/chưa thử.
- Termux: chủ dự án đã thử thật, chạy được. Các distro khác: đường cài tự động **chưa thử**.

## Đọc tiếp
Trao đổi với AI khác: `docs/AI_CHANNEL.md`.

`PROJECT_STATE.md` → `ARCHITECTURE.md` → `DECISIONS.md` → `TESTING.md`.

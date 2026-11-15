# Đóng góp cho Che779 Linux / Termux

Cảm ơn bạn đã quan tâm! Tài liệu này giúp bạn gửi thay đổi nhanh và ít phải sửa lại.

## Trước khi bắt đầu

1. Đọc `docs/PROJECT_STATE.md`, `docs/ARCHITECTURE.md` và `docs/DECISIONS.md`.
2. Mã nguồn script là `apps/linux/che779.sh` — **bản nguồn, chưa có jar**. Bản chạy được (`che779.sh` có jar nhúng) do `scripts/build-release.sh` ghép ra.
3. Emulator V2 lấy từ [Che779-EmulatorV2](https://github.com/Kidtomboy/Che779-EmulatorV2) đúng commit ghi trong `apps/linux/EMULATOR_V2_REF`. Muốn nâng phiên bản V2, đổi file này.

## Cách gửi thay đổi

1. Fork repo, tạo nhánh từ `main`.
2. Sửa `apps/linux/che779.sh`, rồi chạy `bash tests/test-script.sh <đường-dẫn-jar-V2>` (cách lấy jar: `docs/BUILD_AND_RUN.md`).
3. Cập nhật `docs/` và `CHANGELOG.md` nếu hành vi thay đổi.
4. Mở pull request và điền mẫu có sẵn. Ghi rõ **đã thử trên distro/thiết bị nào, gì chưa thử**.

## Nguyên tắc

- **Không điền tay mã SHA-256.** Mã băm do `scripts/build-release.sh` tính từ đúng file jar sau khi mọi thay đổi đã xong.
- Không ghi "đã kiểm tra" khi chưa chạy thật. Termux và từng distro là những môi trường dễ khác nhau.
- Chỉ dùng gói chính thức của distro để cài phần còn thiếu.

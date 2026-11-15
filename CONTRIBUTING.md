# Đóng góp cho Che779 Linux

Cảm ơn bạn đã quan tâm! Tài liệu này giúp bạn gửi thay đổi nhanh và ít phải sửa lại.

## Trước khi bắt đầu

1. Đọc `docs/PROJECT_STATE.md`, `docs/ARCHITECTURE.md` và `docs/DECISIONS.md`.
2. Repo này chứa: script `apps/linux/che779.sh` (bản nguồn, chưa có jar), lệnh đóng gói `apps/linux/packaging/`, mã **Remoter Linux** `apps/linux/remoter-linux/`, và các script đóng gói `scripts/`.
3. Mã Emulator V1/V2 **không nằm ở đây**: lấy từ [Che779-Emulator](https://github.com/Kidtomboy/Che779-Emulator) và [Che779-EmulatorV2](https://github.com/Kidtomboy/Che779-EmulatorV2) đúng commit ghi trong `apps/linux/EMULATOR_V1_REF`, `EMULATOR_V2_REF`. Muốn nâng phiên bản, đổi các file này.

## Cách gửi thay đổi

1. Fork repo, tạo nhánh từ `main`.
2. Sửa `apps/linux/che779.sh`, rồi chạy `bash scripts/fetch-sources.sh && bash scripts/build-jars.sh && bash tests/test-script.sh build/jars/Che779_EmulatorV2.jar && bash tests/test-packages.sh` (cách lấy jar: `docs/BUILD_AND_RUN.md`).
3. Cập nhật `docs/` và `CHANGELOG.md` nếu hành vi thay đổi.
4. Mở pull request và điền mẫu có sẵn. Ghi rõ **đã thử trên distro/thiết bị nào, gì chưa thử**.

## Nguyên tắc

- **Không điền tay mã SHA-256.** Mã băm do `scripts/build-release.sh` tính từ đúng file jar sau khi mọi thay đổi đã xong.
- Không ghi "đã kiểm tra" khi chưa chạy thật. Từng distro là những môi trường dễ khác nhau.
- Chỉ dùng gói chính thức của distro để cài phần còn thiếu.

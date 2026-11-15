# Bàn giao cho AI / người tiếp quản

## Dự án là gì
**Che779 Linux** = bản Linux (V1 + Remoter + V2) của Che779, phát hành `.deb`, `.tar.gz` và `che779.sh`. Repo này **không chứa mã Emulator V1/V2**: Actions lấy từ Che779-Emulator và Che779-EmulatorV2 đúng commit ghim ở `apps/linux/EMULATOR_V1_REF`, `EMULATOR_V2_REF`. Mã riêng của repo: Remoter Linux (`apps/linux/remoter-linux`), script `che779.sh`, lệnh đóng gói, script build.

## Quy tắc
- Sửa **`apps/linux/che779.sh`** (bản nguồn có `@VERSION@`, `@JAR_SHA256@`), không sửa file trong `dist/`/`out/`.
- SHA-256 do script/Actions tính **sau cùng** trên file đã hoàn chỉnh; không điền tay.
- Chạy `bash scripts/fetch-sources.sh && bash scripts/build-jars.sh && bash tests/test-script.sh build/jars/Che779_EmulatorV2.jar && bash tests/test-packages.sh` trước khi commit.
- Tiếng Việt; chỉ ghi "đã kiểm tra" khi thật sự đã chạy (xem `TESTING.md`). Trao đổi với AI khác: `AI_CHANNEL.md`; quyết định: `DECISIONS.md`.
- Termux **không còn** ở repo này (đã chuyển sang Che779-Android, chỉ V2).
- Phiên bản hiện tại: xem `VERSION` (1.3.0). Tag do Cherry tạo tay.

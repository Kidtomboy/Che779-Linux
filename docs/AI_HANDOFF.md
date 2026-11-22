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


## Audit độc lập 1.3.0 — 2026-11-16

Darling đã rà soát source và tài liệu ở revision hiện tại. Danh sách phát hiện, phân loại mức độ xác minh và phạm vi được phép làm nằm trong [AI_CHANNEL.md](AI_CHANNEL.md) (ghi chú mới nhất ở cuối) và GitHub Issue: https://github.com/Kidtomboy/Che779-Linux/issues/2.

**Quy tắc bàn giao:** audit/Issue không phải quyền tự động sửa source. Claude phải chờ Cherry duyệt từng giải pháp/phạm vi; trước khi code cần kiểm tra lại main vì source có thể thay đổi. Sau khi sửa, cập nhật DEBUG_LOG, TESTING, PROJECT_STATE và AI_CHANNEL với bằng chứng build/runtime.

## Đối chiếu version — 2026-11-23 (đồng bộ theo yêu cầu Cherry)
| Nguồn | Giá trị |
|---|---|
| `VERSION` / `PROJECT_STATE.md` | 1.3.0 |
| HEAD `main` | `d8e853236c3c0b2b17ce62d99e0b482c06abbd60` |
| Tag | `v1.3.0` → `84f62ff`; `v1.2.0` → `a3a59f4` |
| Release | Release `v1.3.0`, `v1.2.0` (target `main`) |
- Chưa cài/chạy artifact thực tế: `NOT_RUN`. Mức kiểm tra ở đây chỉ là đối chiếu metadata Git/GitHub (`STATIC_REVIEW`).
- Mọi chênh lệch (nếu có) giữ nguyên là version inconsistency cho đến khi Cherry/Darling xác định nguồn chuẩn; Claude không tự sửa version hay dời tag.

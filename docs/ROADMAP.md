# Lộ trình

Chưa cam kết thời hạn.

- Thử thật trên Fedora, Arch, Alpine, openSUSE, WSL.
- Cân nhắc đóng gói kèm Remoter Linux.
- Tuỳ chọn tự cập nhật script (kiểm tra bản mới trên Releases).
- Mở rộng kiểm thử tự động (giả lập `os-release` các distro).

## 1.3.0 — chia repo theo nền tảng (quyết định của Cherry 15/11/2026)
Xem `DECISIONS.md`. Bản 1.2.0 được phát hành trước, không đổi cấu trúc.
- **Việc của repo này ở 1.3.0:** thêm `scripts/build-deb.sh`, `scripts/build-tar.sh`; nhận Remoter Linux từ P1; build V1+V2 từ commit ghim (thêm `apps/linux/EMULATOR_V1_REF`); bỏ nhánh Termux khỏi `che779.sh` (chuyển sang P4); workflow Phát hành tạo `.deb`, `.tar.gz`, `.sh`, `SHA256SUMS.txt`.

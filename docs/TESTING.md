# Kiểm thử

`bash tests/test-script.sh <jar>` kiểm tra: ghép script, `bash -n`, thay đúng placeholder, SHA-256 trùng jar, tách jar, từ chối khi jar/mã sai, `--version`, `--help`. Kết quả cục bộ: đạt.

| Môi trường | Tình trạng |
|---|---|
| CI Ubuntu (ghép + test + thử khô) | Tự động |
| Termux thật | Chủ dự án đã thử: chạy được |
| Ubuntu/Mint máy thật có màn hình | Chưa xác nhận đầy đủ |
| Fedora, Arch, Alpine, openSUSE, WSL | **Chưa thử** |
| Remoter Linux điều khiển cửa sổ emulator | Chưa thử với WM/Wayland thật |

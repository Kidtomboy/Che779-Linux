# Che779 Project 3 — Offline-first Runtime

> **Trạng thái:** Design proposal / chưa phải bản phát hành  
> **Mục tiêu:** Chuyển Project 3 từ script bootstrap phụ thuộc mạng thành bộ runtime đóng gói sẵn, ưu tiên chạy offline, hỗ trợ Linux và Termux.

## Tầm nhìn

Project 3 nên cung cấp trải nghiệm “lấy gói về một lần, chạy nhiều lần”:

- JAR Emulator và các tài nguyên cần thiết được đóng gói sẵn.
- Launcher kiểm tra môi trường và integrity trước khi chạy.
- Không tải lại những thành phần đã nằm trong gói.
- Game, cấu hình, proxy và save nằm ngoài thư mục runtime để nâng cấp không xóa dữ liệu.
- Có thể bổ sung OCI/Docker image cho Linux, nhưng không bắt buộc Docker trên mọi nền tảng.

## Các kiểu phân phối

| Gói | Nền tảng | Mục đích |
|---|---|---|
| `portable-linux` | Linux desktop | Gói giải nén và chạy, không cần Docker |
| `portable-termux` | Android/Termux | Chạy native, dùng môi trường Termux |
| `oci-linux` | Linux có Podman/Docker | Image đóng gói môi trường tương thích |
| `source` | Nhà phát triển | Script, tài liệu và test |

Tên gói chỉ là đề xuất; chưa có artifact nào được build hoặc xác nhận tương thích ở giai đoạn tài liệu.

## Cấu trúc thư mục mục tiêu

```text
Che779-Project3/
├── README.md
├── LICENSE
├── CHANGELOG.md
├── launcher/
│   ├── che779
│   └── lib/
├── runtime/
│   ├── Che779_EmulatorV2.jar
│   ├── jre/                 # chỉ nếu phân phối JRE hợp lệ cho nền tảng
│   └── assets/
├── config/
│   └── defaults/
├── data/                    # tạo ở runtime; không ghi đè khi cập nhật
│   ├── games/
│   ├── saves/
│   ├── config/
│   └── logs/
├── checksums/
│   └── SHA256SUMS
├── container/
│   ├── Containerfile
│   └── .dockerignore
├── tests/
└── docs/
```

Không nhất thiết phải commit thư mục `data/` hoặc JRE vào Git. Chúng có thể được tạo trong gói phát hành tương ứng.

## Trạng thái hiện tại

Bản script `che779.sh` đã được rà soát sơ bộ. Các điểm cần xử lý trước khi phát hành:

1. JAR nhúng không đồng bộ với bản Project 2 đã kiểm tra.
2. Có lệnh xóa thư mục game trước khi đồng bộ; cần loại bỏ hành vi phá hủy dữ liệu.
3. `--help` có lỗi hiển thị.
4. `--net` chưa trả exit code phản ánh chính xác kết quả kiểm tra.
5. JAR chưa được xác minh bằng checksum trước khi chạy.
6. Vòng đời Termux:X11, wake lock và tiến trình cần cleanup đáng tin cậy.
7. Chưa có kiểm thử cài đặt thực tế trên thiết bị Android/Termux.

Chi tiết và tiêu chí hoàn thành nằm trong `docs/`.

## Nguyên tắc không thỏa hiệp

- Không xóa hoặc ghi đè dữ liệu game/save người dùng khi cài đặt hay cập nhật.
- Không tải mạng trong chế độ offline.
- Không chạy JAR nếu integrity check thất bại.
- Không tuyên bố hỗ trợ nền tảng nếu chưa có kiểm thử trên nền tảng đó.
- Không đóng gói JRE hoặc thư viện bên thứ ba nếu chưa xác minh giấy phép và điều kiện phân phối.

## CHE779 maintenance follow-up — 2026-11-13

- The `run()` helper now applies a default 1,800-second command timeout when the `timeout` utility is installed.
- Override the limit with `CHE_RUN_TIMEOUT` (seconds). If `timeout` is unavailable, the script warns and executes without an enforced deadline.

Validate with `bash -n che779.sh`, `bash che779.sh --help`, and `CHE_DRY=1 bash che779.sh`. The dry-run verifies the embedded JAR; it does not perform a real package installation or game runtime test.

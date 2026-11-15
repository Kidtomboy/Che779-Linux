# Quyết định thiết kế

1. **Một file duy nhất.** Người dùng chỉ tải `che779.sh`; jar nhúng sẵn bằng base64 sau `__JAR__`.
2. **Gói chính thức của distro** cho Java/Xvfb, không tải tay, không giải nén tay.
3. **SHA-256 tính sau cùng** từ jar thật, bằng `build-release.sh`; không điền tay.
4. **Ghim V2 bằng commit** (`EMULATOR_V2_REF`) để bản phát hành tái lập được.
5. **Gỡ `che779.sh` 1,2 MB khỏi gốc repo**: bản chạy được chỉ có ở Releases (tránh nhúng file nhị phân vào git).
6. **Phiên bản 1.2.0**, đồng bộ với 3 repo còn lại; CHANGELOG chỉ ghi bản hiện tại.
7. **Không bó Remoter Java** vào script ở bản này.

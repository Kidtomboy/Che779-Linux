# Build và chạy

## Người dùng
Tải `che779.sh` + `SHA256SUMS.txt` từ mục **Releases**, kiểm tra: `sha256sum -c SHA256SUMS.txt`, rồi `bash che779.sh`.

## Nhà phát triển
Cần: bash, coreutils, base64, JDK 17+ (để build jar V2).

```bash
# 1. Lấy V2 đúng commit đã ghim
git clone https://github.com/Kidtomboy/Che779-EmulatorV2.git emulator-v2
git -C emulator-v2 checkout "$(cat apps/linux/EMULATOR_V2_REF)"
# 2. Build jar
(cd emulator-v2/apps/emulator-v2/source && bash build.sh)
# 3. Kiểm thử
bash tests/test-script.sh emulator-v2/apps/emulator-v2/source/Che779_EmulatorV2.jar
# 4. Ghép bản phát hành
bash scripts/build-release.sh emulator-v2/apps/emulator-v2/source/Che779_EmulatorV2.jar out
cd out && sha256sum che779.sh > SHA256SUMS.txt
```

Thử khô không cần màn hình: `CHE_DRY=1 CHE_OUT=/tmp/x bash out/che779.sh` (chỉ tách và kiểm tra jar).

## Phát hành tự động
Gắn thẻ: `git tag v1.2.0 && git push origin v1.2.0` → workflow `release.yml` thực hiện đúng các bước trên và đăng `che779.sh` + `SHA256SUMS.txt`.

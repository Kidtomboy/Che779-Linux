# Build và chạy

## Người dùng
Xem README: cài `.deb`, hoặc giải nén `.tar.gz`, hoặc `bash che779-linux.sh`. Kiểm tra file: `sha256sum -c SHA256SUMS.txt`.

## Nhà phát triển
Cần: `git`, JDK 8+, `bash`, `base64`, `sha256sum`; `dpkg-deb` để làm `.deb`.
```bash
bash scripts/fetch-sources.sh        # mã V1, V2 đúng commit ghim -> build/src-v1, build/src-v2
bash scripts/build-jars.sh           # -> build/jars/*.jar
bash tests/test-script.sh build/jars/Che779_EmulatorV2.jar
bash tests/test-packages.sh
bash scripts/package-tar.sh && bash scripts/package-deb.sh      # -> dist/
bash scripts/build-release.sh build/jars/Che779_EmulatorV2.jar  # -> dist/che779-linux.sh
(cd dist && sha256sum che779-linux.sh *.tar.gz *.deb > SHA256SUMS.txt)  # làm SAU CÙNG
```
Dùng mã cục bộ thay vì clone: `SRC_V1=/đường/dẫn SRC_V2=/đường/dẫn bash scripts/build-jars.sh`.
Thử `che779-linux.sh` không cần màn hình: `CHE_DRY=1 CHE_OUT=/tmp/x bash dist/che779-linux.sh`.

## Phát hành
`git tag v1.3.0 && git push origin v1.3.0` (hoặc Releases → Draft a new release) → workflow `release.yml` làm đúng các bước trên và đăng file.

## Termux (apps/termux)
```bash
bash apps/termux/fetch-jar.sh v2          # lấy và build jar V2 đúng commit ghim -> build/termux/
bash tests/test-termux.sh build/termux/Che779_EmulatorV2.jar
bash apps/termux/build-termux.sh build/termux/Che779_EmulatorV2.jar Che779_EmulatorV2.jar dist/che779-termux.sh
```
Linux: `che779-linux.sh` (xem phần trên); hai file này độc lập.

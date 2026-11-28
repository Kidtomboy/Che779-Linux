# Build và chạy

## Người dùng
Xem README: cài `.deb`, hoặc giải nén `.tar.gz`, hoặc `bash che779-linux-v2.sh` (V1: `-v1`). Kiểm tra file: `sha256sum -c SHA256SUMS.txt`.

## Nhà phát triển
Cần: `git`, JDK 8+, `bash`, `base64`, `sha256sum`; `dpkg-deb` để làm `.deb`.
```bash
bash scripts/fetch-sources.sh        # mã V1, V2 đúng commit ghim -> build/src-v1, build/src-v2
bash scripts/build-jars.sh           # -> build/jars/*.jar
bash tests/test-script.sh
bash tests/test-packages.sh
for v in v1 v2; do bash scripts/package-tar.sh $v; bash scripts/package-deb.sh $v; bash scripts/build-release.sh $v; done   # -> dist/
(cd dist && sha256sum che779-linux-v1.sh che779-linux-v2.sh *.tar.gz *.deb > SHA256SUMS.txt)  # làm SAU CÙNG
```
Dùng mã cục bộ thay vì clone: `SRC_V1=/đường/dẫn SRC_V2=/đường/dẫn bash scripts/build-jars.sh`.
Thử `che779-linux.sh` không cần màn hình: `CHE_DRY=1 CHE_OUT=/tmp/x bash dist/che779-linux-v2.sh`.

## Phát hành
`git tag v1.3.1 && git push origin v1.3.1` (hoặc Releases → Draft a new release) → workflow `release-linux.yml` làm đúng các bước trên và đăng file.

## Termux (apps/termux)
```bash
bash apps/termux/fetch-jar.sh v2 && bash apps/termux/fetch-jar.sh v1   # jar đúng commit ghim -> build/termux/
bash tests/test-termux.sh
bash apps/termux/build-termux.sh v2 build/termux/Che779_EmulatorV2.jar dist/che779-termux-v2.sh
bash apps/termux/build-termux.sh v1 build/termux/Che779_Emulator.jar dist/che779-termux-v1.sh
```
Linux: `che779-linux-v1.sh` / `-v2.sh` (xem phần trên); hai file này độc lập.

# Build và chạy

## Người dùng
Xem README: cài `.deb`, hoặc giải nén `.tar.gz`, hoặc `bash che779.sh`. Kiểm tra file: `sha256sum -c SHA256SUMS.txt`.

## Nhà phát triển
Cần: `git`, JDK 8+, `bash`, `base64`, `sha256sum`; `dpkg-deb` để làm `.deb`.
```bash
bash scripts/fetch-sources.sh        # mã V1, V2 đúng commit ghim -> build/src-v1, build/src-v2
bash scripts/build-jars.sh           # -> build/jars/*.jar
bash tests/test-script.sh build/jars/Che779_EmulatorV2.jar
bash tests/test-packages.sh
bash scripts/package-tar.sh && bash scripts/package-deb.sh      # -> dist/
bash scripts/build-release.sh build/jars/Che779_EmulatorV2.jar  # -> dist/che779.sh
(cd dist && sha256sum che779.sh *.tar.gz *.deb > SHA256SUMS.txt)  # làm SAU CÙNG
```
Dùng mã cục bộ thay vì clone: `SRC_V1=/đường/dẫn SRC_V2=/đường/dẫn bash scripts/build-jars.sh`.
Thử `che779.sh` không cần màn hình: `CHE_DRY=1 CHE_OUT=/tmp/x bash dist/che779.sh`.

## Phát hành
`git tag v1.3.0 && git push origin v1.3.0` (hoặc Releases → Draft a new release) → workflow `release.yml` làm đúng các bước trên và đăng file.

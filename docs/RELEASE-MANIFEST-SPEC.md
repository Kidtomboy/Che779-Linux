# Release manifest specification (đề xuất)

Mỗi artifact phát hành cần có một manifest JSON tương tự:

```json
{
  "project": "Che779-Project3",
  "version": "0.1.0",
  "channel": "preview",
  "source_revision": "<git-commit>",
  "target": {
    "os": "linux",
    "arch": "x86_64",
    "format": "portable"
  },
  "runtime": {
    "java": "system-java-17-or-compatible",
    "bundled": false
  },
  "files": [
    {
      "path": "runtime/Che779_EmulatorV2.jar",
      "size": 0,
      "sha256": "<sha256>"
    }
  ]
}
```

Các giá trị `<...>` là placeholder, không được dùng nguyên trạng trong release. `size` và `sha256` phải được tính từ artifact cuối cùng.

## Quy tắc

- Một manifest riêng cho mỗi target artifact.
- Không dùng một checksum chung cho mọi kiến trúc/gói.
- Không đưa secrets hoặc đường dẫn máy build vào manifest.
- Release phải có `SHA256SUMS`.
- Tốt hơn nữa: ký manifest/checksum bằng chữ ký số.
- Ghi rõ Java runtime bundled hay system-provided.

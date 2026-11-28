# AI Audit Handoff — Project 3 (2026-11-28)

> QA coverage snapshot; khoảng trống kiểm thử không mặc định là lỗi.

## Repository baseline
- Repo: Kidtomboy/Che779-Linux
- VERSION: 1.3.1
- main HEAD đã đọc: ced414be05059f4e98af08769468d7bfc832bb88
- Audit issue mới: https://github.com/Kidtomboy/Che779-Linux/issues/3
- Issue QA cũ được thay đầu mối: https://github.com/Kidtomboy/Che779-Linux/issues/2
- Issue parity đã hoàn thành, giữ đóng: https://github.com/Kidtomboy/Che779-Linux/issues/1

## Bằng chứng docs
- docs/TESTING.md blob c1be854ced33347398f5d99efc5090b84105d01c.
- docs/DEBUG_LOG.md blob abea04ab36c3032bee9235f516f2b97b5b6ae202.
- Ubuntu 24.04 .deb + V2/game/Xvfb; V1 3 tabs Xvfb (tên launcher cũ); V1 launcher dưới Xvfb chưa mở game.
- Fedora/Arch/Alpine/openSUSE, Debian/Mint thật, desktop window manager/Wayland, xdotool reorder: chưa thử.
- Termux X1/X2 BUILD_VERIFIED; X3 CI_VERIFIED khi workflow xanh; X4 thiết bị Termux thật NOT_RUN.
- Latest CI gần nhất được ghi nhận xanh tại HEAD ced414be.

## Checklist bàn giao
- Desktop Linux thật: DE/window manager, X11 hoặc Wayland, game thật.
- Debian/Mint: cài .deb trên distro thật.
- Fedora/Arch/Alpine/openSUSE: kiểm tra bootstrap Java và launcher.
- xdotool reorder: chỉ X11; kiểm tra hành vi và thông báo giới hạn trên Wayland.
- Termux thật: chạy cả V1/V2 trên thiết bị, ghi Android/Termux/Java versions.
- Tab/process/IPC/port exhaustion và từng nút GUI: kiểm tra chức năng chứ không chỉ cửa sổ launch.
- Kiểm tra pin P1/P2 refs; khi P1/P2 cập nhật, P3 đồng bộ ref, chạy tests và cập nhật docs theo quy tắc của Cherry.

## Không được suy diễn
- CI xanh không chứng minh distro/desktop/Termux thật.
- Xvfb launch không chứng minh GUI thao tác đầy đủ.
- Coverage gap chỉ trở thành bug khi có reproduction + log.

# salem — Lenovo ThinkPad X1 Yoga 4th Gen

Hostname `salem` (also on the sticker). Convertible (360° hinge, touch + pen).

## Hardware (Lenovo spec sheet, MTM 20QGS0UC00)
- CPU: Intel Core i7-8565U (Whiskey Lake, 4C/8T)
- RAM: 16 GB LPDDR3-2133, soldered (not upgradeable)
- Disk: 1 TB PCIe NVMe
- GPU: Intel UHD 620
- Display: 14" UHD (3840x2160) touch
- WiFi/BT: Intel Wireless-AC 9560, Bluetooth 5.0
- Camera: IR + HD, ThinkShutter
- Ports: 2x Thunderbolt 3 (USB-C), 2x USB-A 3.1, HDMI 1.4, audio, native Ethernet (needs dongle), WWAN SIM slot
- Warranty: out of warranty; end of service 2026-01-18, so expect no more BIOS updates

Links:
- Arch Wiki: https://wiki.archlinux.org/title/Lenovo_ThinkPad_X1_Yoga_(Gen_4)
- Lenovo PSREF: https://psref.lenovo.com/Product/ThinkPad/ThinkPad_X1_Yoga_4th_Gen

## System setup
- BIOS N2HET77W (1.60, 2024-02-06), probably final
- Boot: systemd-boot + dracut (EndeavourOS default); kernel parameters live in `/etc/kernel/cmdline`
- Disk: nvme0n1p1 `/efi`, p2 LUKS → btrfs (`@`, `@home`, `@cache`, `@log`), p3 LUKS → swap (17 GB, used for hibernate)
- Battery charge limits: 70–80 % (set in KDE Settings → Power; stored in the ThinkPad firmware)
- Power: power-profiles-daemon (KDE switches it: balanced on AC, power-saver on battery)

## Health log
- 2026-10-24: battery at 78 % of design capacity (39.8/51.0 Wh), 375 cycles

# tukey — Fujitsu LIFEBOOK U9413 (work laptop)

Hostname `tukey`. 14" ultralight clamshell (magnesium, silver-white, 908 g and up) from 2023,
Intel 13th gen (Raptor Lake-U), Evo/vPro platform. My **work laptop**; EndeavourOS + KDE Plasma
(Wayland), same setup as salem. Fujitsu's PC business is now "Fujitsu Client Computing Limited"
(FCCL, ex-Fujitsu Technology Solutions), which is the vendor string in DMI.

Identifiers: **DSGT002137** is the system serial number (confirmed with dmidecode, it is what the Fujitsu
support site asks for). **FPC02714BK** is the order code of this configuration (the `FPC…` prefix is
Fujitsu's order-code style; web search finds nothing for it, so it says nothing about the specs). The
configuration below comes from measurements on the machine itself.

## Hardware
Measured here (2026-10-27) unless marked *(datasheet)*, which means the Fujitsu data sheet for the
U9413 family and not necessarily this unit.
- CPU: **Intel Core i5-1335U** (Raptor Lake-U, 2P + 8E = 10 cores / 12 threads, up to 4.6 GHz, 12 MB L3,
  15 W base / up to 55 W turbo), family 6 model 186 stepping 3, microcode 0x6134. VT-x is on. Fujitsu
  only sells this CPU for retail/SMB/education/government; the other U9413 CPUs are i5-1350P and i7-1370P.
- RAM: **16 GB LPDDR5, soldered**: 8 x 2 GiB **Micron MT62F1G32D2DS-026** packages (dmidecode
  "Onboard Controller0/1, Channel A–D"), 6400 MT/s configured, no ECC, MemTotal 15.2 GiB. U9413 comes with
  8/16/32 GB onboard *(datasheet)*. **Not upgradeable, and cannot be swapped**: a RAM fault means a new mainboard.
- Disk: **Samsung MZVL21T0HCLR-00B07** (PM9A1, 1 TB, 953.9 GiB), PCIe 4.0 NVMe M.2 2280, firmware
  `GXA7802Q`, serial `S63GNX0W708956`. The data sheet lists SED (self-encrypting) modules for this
  family, but fwupd's security check reports "hardware disk encryption: not supported", so don't count on
  it. Single M.2 slot. SMART in "Storage" below.
- GPU: Intel Iris Xe (Raptor Lake-P, `8086:a7a1`), i915 (xe module also present)
- Display: **BOE NV140WUM-N61**, 14" 16:10 WUXGA 1920x1200, anti-glare, 400 cd/m² *(datasheet)*;
  a touch variant exists, this one is non-touch (no touch device in the input list). KDE scale 1.1,
  VRR automatic, brightness control via `intel_backlight` (max 91428). Panel number is what spare-part
  searches need.
- WiFi/BT: **Intel Wi-Fi 6E AX211 160 MHz** (CNVi, `8086:51f1`), iwlwifi firmware `so-a0-gf-a0-89`;
  Bluetooth `8087:0033` (USB). Hardware is BT 5.3 ready.
- LAN: Intel **I219-LM** Gigabit (`8086:0dc5`, `enp0s31f6`), flap-style RJ-45 port, vPro/AMT capable
- WWAN: optional (Fibocom FM350-GL 5G or Quectel EM120R-GL 4G) *(datasheet)* — **none fitted here**
  (no modem on PCI/USB)
- Audio: Intel Raptor Lake cAVS with **Realtek ALC257** codec, driven by **SOF** (`sof-hda-dsp`,
  `sof-firmware` needed), 2 speakers, 2 digital mics (with the webcam), combo jack, HDMI audio.
  **Speakers work; the internal DMICs show up (SOF finds 2 in NHLT) but record only digital silence**
  (checked 2026-10-27 via PipeWire and `arecord -D hw:0,6`, after a full shutdown, BIOS devices all on).
  `/etc/modprobe.d/alsa-base.conf` (`snd-intel-dspcfg dsp_driver=1`, legacy HDA driver, no DMIC) was
  removed and then put back on request on 2026-10-27; with it the digital mics never show up. Never use
  the "Pro Audio" card profile; keep `HiFi (… Mic1, Mic2, Speaker)`.
  Workaround: external USB webcam mic.
- Camera: Chicony "Integrated Camera" `04f2:b7ca` (firmware 2.1, updatable via fwupd), four `/dev/video*`
  nodes. `/dev/video0` is the RGB camera (MJPG up to 1920x1080 @ 30 fps), `/dev/video2` is a
  **640x360 GREY 8-bit stream, i.e. the IR camera is fitted** (Windows Hello type; face login on Linux
  would need Howdy, not set up). Privacy shutter *(datasheet)*.
- Input: backlit 85-key keyboard without trackstick (AT keyboard + `Fujitsu FUJ02E3` hotkey device),
  Synaptics I2C touchpad `06CB:CED3`
- Card reader: Realtek **RTS525A** PCIe (`rtsx_pci`), **microSD** slot (UHS-II capable). The backup card
  sits in it, see "Backup".
- Security hardware: **TPM 2.0, Nuvoton NPCT75x** (`/dev/tpm0`, `tpmrm0`), Intel ME 16.1.27.2225 (vPro),
  Kensington lock. No fingerprint reader found in `lsusb` (PalmSecure/fingerprint are options),
  no SmartCard reader seen (option).
- Ports: 2x Thunderbolt 4 / USB4 (USB-C, 40 Gbit/s, DP 1.4, PD, charging), 2x USB-A 3.2 Gen 1 (one with
  "Anytime USB charge"), HDMI 2.0 (4K60), RJ-45, microSD, 3.5 mm combo jack, nano-SIM (WWAN models only)
- Battery: Fujitsu **CP842140-01**, 4-cell Li-ion, 15.4 V, 4196 mAh = **64 Wh** design, fast charge
  to 80 % in 1 h *(datasheet)*, serial `01A-P230717002965N`
- Power: 20 V / 65 W USB-C adapter (slim); the optional Thunderbolt 4 port replicator needs 170 W
- Size/weight: 308.8 x 209 x 15.8–17.3 mm, from 908 g; MIL-STD-810H tested
- Warranty: 2 years in EMEIA *(datasheet)*; purchase date unknown, so check the status on the Fujitsu
  support site with the serial. Spare parts promised for at least 5 years after shipment.

Identity (from `/sys/class/dmi/id`, 2026-10-27):
- Vendor `FUJITSU CLIENT COMPUTING LIMITED`, product **LIFEBOOK U9413**, product version `10601115935`,
  SKU `SK00`, family `LIFEBOOK-FTS`, chassis type 10 (notebook)
- Board **FJNB300**, rev `A3`; regulatory model **9U14A4** *(datasheet)*
- System serial **DSGT002137**, UUID `a2ed4700-81bd-11ee-8b14-ed46fe99d364` (dmidecode, 2026-10-27)
- Embedded controller firmware 63.19 (`efr63.19` in the DMI modalias)
- machine-id `262cb39665104c77a5fd15b833d1405f`; Tailscale node `100.123.122.106`
- MACs: wlan0 `E4:0D:36:F4:A3:17`, enp0s31f6 `E4:46:B0:43:7F:F7`

### PCI devices (lspci -nn)
| Address | ID | Device |
|---|---|---|
| 00:00.0 | 8086:a708 | Host bridge (Raptor Lake-P/U 2P+8E) |
| 00:02.0 | 8086:a7a1 | Iris Xe Graphics |
| 00:04.0 | 8086:a71d | DTT (platform and thermal framework) |
| 00:06.0 | 8086:a74d | PCIe 4.0 root port → NVMe |
| 00:07.0/.1 | 8086:a76e / a73f | Thunderbolt 4 PCIe root ports |
| 00:08.0 | 8086:a74f | GNA scoring accelerator |
| 00:0a.0 | 8086:a77d | Crashlog and telemetry |
| 00:0d.0/.2 | 8086:a71e / a73e | Thunderbolt 4 USB controller / NHI |
| 00:14.0 | 8086:51ed | USB 3.2 xHCI |
| 00:14.3 | 8086:51f1 | CNVi WiFi (AX211) |
| 00:15.0/.1/.3 | 8086:51e8/51e9/51eb | Serial IO I2C (touchpad etc.) |
| 00:16.0 | 8086:51e0 | HECI (Intel ME) |
| 00:1c.0, 00:1c.7 | 8086:51b8 / 51bf | PCIe root ports (card reader) |
| 00:1f.0 | 8086:519d | LPC/eSPI |
| 00:1f.3 | 8086:51ca | cAVS audio |
| 00:1f.4/.5 | 8086:51a3 / 51a4 | SMBus / SPI controller |
| 00:1f.6 | 8086:0dc5 | I219-LM Ethernet |
| 01:00.0 | 144d:a80a | Samsung PM9A1 NVMe |
| 5b:00.0 | 10ec:525a | Realtek RTS525A card reader |

### USB devices (lsusb)
| ID | Device |
|---|---|
| 04f2:b7ca | Chicony Integrated Camera |
| 8087:0033 | Intel AX211 Bluetooth |
| 046d:c52b | Logitech Unifying receiver (for the M720 Triathlon mouse, firmware RQR12.11) |

Links:
- Fujitsu data sheet (PDF): https://www.fujitsu.com/au/imagesgig5/ds_LIFEBOOK_U9413_AU.pdf
- Fujitsu support, drivers and BIOS by serial number: https://support.ts.fujitsu.com/
- Laptopmedia specs: https://laptopmedia.com/laptop-specs/fujitsu-lifebook-u9413-u9413-rx/specs/
- Kingston compatibility page (memory/SSD notes): https://kingston.com/cn/memory/search/model/109851/fujitsu-lifebook-u9413-n
- Arch Wiki has no page for this model; the generic Intel/Thunderbolt/SOF pages apply

## System setup
- EndeavourOS, kernel 7.2.11-arch1-1, systemd 262
- Firmware: **InsydeH2O**, UEFI 2.8, BIOS **Version 2.10 (2023-09-08)** (fwupd UEFI resource 135168 = 0x21000).
  The CPE database lists a 2.12, so 2.10 is probably **not the newest**; Fujitsu publishes BIOS
  updates as Windows tools on its support site, and `fwupdmgr get-updates` offers nothing.
- Boot: systemd-boot + dracut (EndeavourOS default); kernel parameters live in `/etc/kernel/cmdline`
- Disk: nvme0n1p1 `/efi` (2 GB), p2 LUKS → btrfs (`@`, `@home`, `@cache`, `@log`; zstd:3, noatime), p3 LUKS →
  swap (16.7 GB, used for hibernate). Same layout as salem.
- Kernel cmdline (2026-10-27): `nvme_load=YES nowatchdog rw rootflags=subvol=/@ rd.luks.uuid=… resume=/dev/mapper/luks-8a4f18bb-… systemd.machine_id=…`
  (LUKS root `0ca8fe3e-4d9f-4dbf-8bb8-f8d1dd51999e`, LUKS swap `8a4f18bb-6c82-4d9d-b206-0b04a56535d3`)
- Secure Boot: **disabled**. The firmware DB holds Fujitsu's 2012/2022 certificates and Microsoft's 2011
  CAs; dbx is the old `20220801`.
- Sleep: `/sys/power/mem_sleep` = `[s2idle] deep`, s2idle is the default and is what runs (journal:
  `PM: suspend entry (s2idle)` / `suspend exit`, resumes fine). fwupd's check lists "Suspend-to-idle:
  Enabled, Suspend-to-ram: Disabled". Whether `deep` (S3) works has not been tried.
- Power: power-profiles-daemon (active; KDE switches profiles), TLP is not running. CPU driver
  `intel_pstate`.
- **Battery charge limit: 85 %, set on purpose** in KDE Settings → Power. The kernel only offers
  `charge_control_end_threshold` (no start threshold) in `/sys/class/power_supply/CMB1/`; it reads **85**
  (checked 2026-10-27). Earlier the same day `upower` showed 75/80 % while sysfs read 100, so KDE's saved
  value and the kernel value can disagree; check sysfs, not upower, if in doubt. Whether it survives a
  reboot is untested.
- Displays seen by DRM: eDP-1 plus DP-1, DP-2 (USB-C DisplayPort alt mode) and HDMI-A-1

### Firmware inventory (fwupd, 2026-10-27)
| Component | Version |
|---|---|
| System firmware / BIOS | 2.10 (UEFI resource 135168) |
| Intel ME | 16.1.27.2225 |
| TPM (Nuvoton NPCT75x) | 7.2.3.1 |
| NVMe MZVL21T0HCLR-00B07 | GXA7802Q |
| Chicony camera | 2.1 |
| Logitech Unifying receiver | RQR12.11_B0032 (bootloader BOT01.04_B0016) |
| UEFI dbx | 20220801 |

- CPU microcode 0x6134.
- The SPI controller is visible to fwupd as "BIOS1" / "PCH SPI Controller" (flags: updatable). The
  security check says SPI write disabled, SPI lock enabled, BIOS region locked, and two "Locked MTD:
  Unlocked" entries (informational). Do **not** flash anything through it by hand; no vendor-supplied LVFS
  payload exists for this machine.
- fwupd lists no update for any device. The "requires AC power" warning on the NVMe and BIOS is normal on battery.

### Security state (fwupd `fwupdmgr security`, 2026-10-27): HSI:1
- Passing: BIOS updates enabled, Intel ME key manifest valid, CSME 16.1.27.2225 valid, platform debugging
  disabled/locked, SPI write disabled, SPI lock and BIOS region locked, TPM 2.0 present, **Intel BootGuard
  enabled** (ACM, OTP fuse, verified boot all valid), GDS mitigation, **IOMMU enabled** (so VT-d is on),
  **pre-boot DMA protection enabled**, SMAP, CET supported, swap encrypted.
- Failing / not available: "Locked MTD: Unlocked" (2 entries) and "Not supported" (2), encrypted RAM not
  supported, hardware disk encryption not supported, kernel lockdown disabled.
- That is HSI:1 with the HSI-2 items blocked only by the MTD entries; nothing here needs fixing.

### BIOS settings
Not readable from Linux here: there is no `/sys/class/firmware-attributes` (no think-lmi equivalent
for Insyde/Fujitsu), so check them by hand with **F2** in the BIOS (boot menu key not verified, try **F12**). Open items:
- Is a supervisor/user BIOS password set? (the data sheet says the BIOS supports both)
- Thunderbolt security level (`bolt` / `boltctl` is **not installed**, so Thunderbolt devices cannot be
  authorized from KDE) and the vPro/AMT state (AMT could be exposed on the LAN; check that MEBx is not provisioned)

### Backup, sync and role
- Syncthing: `~/Work`, `~/LinuxConfig`, `~/Documents`, `~/Pictures` (see `AGENTS.md`).
- Backup: **restic to the microSD card** in the built-in reader — a 461 GiB btrfs card labelled
  `BackupLG`, mounted at `/media/lukas/BackupLG` (92 GB used, 369 GB free), repo `restic-repo`, driven by
  `bin/restic_sd_backup.sh` through the **user** timer `restic-sd-backup.timer` (runs every 30 min, 43
  snapshots of `/home/lukas`, about 60 GiB each, pruned with `forget`). Only tukey has this (`bin/backup_local.sh` also writes `homebak/` to the
  same card). The card is small and external to the disk, so it does not protect
  against theft or loss of the whole bag.
- Encryption: the disk is LUKS encrypted. The card itself is a plain btrfs filesystem, but the restic
  repository on it is always encrypted by restic (password in `~/.config/restic/sd_password`), so the
  backup is not readable without that password. Only the filenames of the card's top level and the repo
  structure are visible.

### Thermals and power (measured 2026-10-27, idle, on battery, power-saver)
- Package 51 °C, cores 46–50 °C, ACPI zone 51 °C, WiFi 38 °C, NVMe composite 46 °C
  (warning 80.8 °C / critical 84.8 °C). Package high/crit = 100 °C.
- The fan is an ACPI fan (`acpi_fan` hwmon, `fan1_input`); no load test done yet. The chassis is very thin
  and the CPU is 15 W class, so sustained load will throttle. salem's `stress-ng` comparison could be repeated here.
- Kernel: `ACPI: thermal: [Firmware Bug]: No valid trip points!` (benign, see below).

### Storage (SMART, 2026-10-27)
- SAMSUNG **MZVL21T0HCLR-00B07**, 1.02 TB, serial `S63GNX0W708956`, firmware GXA7802Q, NVMe 1.3, 512 B LBA,
  259 GB used
- Health **PASSED**, 1 % used, spare 100 %, **0 media/data-integrity errors**, 0 error-log entries, no self-test run yet
- 354 power-on hours, 238 power cycles, 10.0 TB written / 31.4 TB read, 24 unsafe shutdowns
- Temperature 43 °C idle, warning 81 °C / critical 85 °C
- Opal/encryption state not read (`nvme-cli` is not installed)

### Video decode — gotcha (same as salem)
- `vainfo` **fails** on the host (`vaInitialize failed, error -1`): neither `intel-media-driver` nor
  `libva-intel-driver` is installed, so there is no VAAPI driver on the host.
- The Arch Firefox/Chromium therefore decode video in software. If you want hardware decode on Iris Xe,
  `intel-media-driver` (iHD) is the package. It is a new path on all my machines, so test it before blaming it for anything.
- In `chrome://gpu`, trust the decoder list under "Video Acceleration Information", not the "Video Decode" feature line.

### Benign kernel messages (seen at every boot, don't chase them)
`virt/tdx: TDX not supported by the host platform` · `ACPI: thermal: [Firmware Bug]: No valid trip points!` ·
`hpet_acpi_probe: no address or irqs in _CRS` · `i8042: PNP: PS/2 appears to have AUX port disabled` ·
`ENERGY_PERF_BIAS: Set to 'normal', was 'performance'` ·
`resource sanity check … igen6_probe … mapping multiple BARs` (igen6_edac) ·
`intel-hid INTC1078:00: failed to get button capability` / `failed to enable HID power button` ·
`spi-nor spi0.x: supply vcc not found, using dummy regulator` ·
`ACPI BIOS Error (bug): Could not resolve symbol [^^RP28.PXSX.WIST]` + `\_SB.PC00.CNVW._DSM` aborted (Fujitsu's WiFi ACPI method) ·
`skl_hda_dsp_generic: ASoC: Parent card not yet available, widget card binding deferred` ·
`hda_dsp_hdmi_build_controls: no PCM in topology for HDMI converter 3` ·
`kdeconnectd uses wireless extensions which will stop working for Wi-Fi 7 hardware`

### Docked / usual peripherals (as of 2026-10-27)
Logitech M720 Triathlon mouse through a Unifying receiver. WiFi network in use right now:
`Funkloch_404_5GHz`. A dock or monitor was not connected at the time of the probe.

### Maintenance (set up 2026-10-27)
- `paccache.timer` (weekly, keeps 3 versions) keeps `/var/cache/pacman/pkg` small; it had grown to 56 GB without it.
- `reflector.timer` (weekly) rewrites `/etc/pacman.d/mirrorlist` from `/etc/xdg/reflector/reflector.conf`
  (HTTPS, CH/DE/AT/FR, synced within 12 h, 20 fastest). The EndeavourOS list is separate: `eos-rankmirrors`.
- pacnew files merged 2026-10-27, originals in `/var/backups/pacnew-2026-10-27/`. Kept our own `pacman.conf`
  (EOS repo, multilib, HoldPkg, Color) and our `OPTIONS` in `makepkg.conf` (no debug packages, no LTO).
  Check for new ones after updates with `pacdiff`.
- Caches that are safe to clear: `~/.cache/yay/*/` (keep `vcs.json`), `pip cache purge`, `~/.cache/R/pkgcache`.
  **Not** `~/.cache/R/renv`: R projects link their libraries into it.
- Orphans removed 2026-10-27 except `vlc`, which is kept on purpose (`pacman -Qdtq` will keep listing it).
  `eos-reboot-recommended` went with them.

## Differences to the other machines
- vs **salem** (X1 Yoga Gen 4): newer CPU (13th vs 8th gen, 10 cores vs 4), Thunderbolt 4 vs 3, LPDDR5 vs
  LPDDR3, lighter (908 g and up), no touch/pen/360° hinge, no fingerprint reader (but IR camera) in this unit,
  Insyde BIOS without `think-lmi`, SOF audio instead of the legacy HDA driver, Samsung PM9A1 SSD instead of Intel,
  battery limit (85 %) via the generic sysfs interface, IR camera in this unit.
- vs **acer** (Swift 3): socketed RAM and a 2.5" bay there; here everything is soldered except the SSD.

## Still open
- Warranty status on the Fujitsu support site (serial DSGT002137)
- BIOS 2.10 vs the newer release (2.12?) on the Fujitsu support site, read its notes first
- Does `deep` sleep work? (`echo deep | sudo tee /sys/power/mem_sleep`, then suspend and compare drain)
- Install `bolt` if Thunderbolt peripherals are used; install `nvme-cli` for the Opal check
- `memtest86+` once (RAM is soldered; this is the only baseline you will ever get)

## Health log
- 2026-10-27: battery 56.87 of 64.62 Wh design = **88 %**, **23 cycles**, 94 % charged, discharging at 4.4 W
  (about 12 h estimated). SSD 1 % used, 354 h, 0 errors. BIOS 2.10, kernel 7.2.11. RAM test not done.
- 2026-10-27: cleanup (pacman cache, user caches, 100 orphan packages) took disk use from 195 to 126 GB.
  121 updates still pending at that point.

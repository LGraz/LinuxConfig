# salem — Lenovo ThinkPad X13 Gen 5 (Type 21LV)

My private laptop. 13.3" clamshell, bought used in early November 2026.

**Status 2026-11-03: not set up yet.** The factory Samsung SSD stays in, since the base cover wouldn't come off (see "SSDs"). The plan is to copy the
EndeavourOS install from the old 1 TB Intel onto it (see "Moving the install"). The hostname, Tailscale identity and data
come with that copy, so this laptop becomes `salem` when it boots from it. The previous hardware, an X1 Yoga Gen 4, now runs as `dirichlet`, see `machines/dirichlet.md`.

*(check)* means measured by `user_scripts/laptop-check` from a Fedora live USB on 2026-11-03. *(Lenovo)* means the warranty
page for this serial number, *(PSREF)* means Lenovo's spec sheet for the whole model, where the check doesn't show which
variant this unit has.

## Hardware
- Model: MTM **21LVS92200**, GTIN 0198158526678
- Serial: **GM0XVMHB** *(check: matches)*
- BIOS: N45ET29W (1.19, 2026-06-22) *(check)*
- CPU: Intel Core Ultra 5 **135U** vPro (Meteor Lake, 12 cores: 2 P + 8 E + 2 LP E, 14 threads, up to 4.4 GHz)
- RAM: 32 GB LPDDR5X, **soldered**, 8 x 4 GiB rated 7500 MT/s, 30.8 GB usable *(check)*. PSREF says it runs at 6400
  because of a platform limit.
- Disk slot: **one M.2 2280, PCIe 4.0 x4**, up to 2 TB *(PSREF)*. Factory disk: Samsung PM9C1a 512 GB *(check)*, see "SSDs"
- GPU: Intel Graphics, Meteor Lake-P *(check)*; not Arc, that needs an H-series CPU
- Display: 13.3" WUXGA (1920x1200, 16:10) *(check)*. IPS, either 300 nits touch, 300 nits non-touch or 400 nits low
  power non-touch; which one is still to check *(PSREF)*
- WiFi/BT: Intel Wi-Fi 6E **AX211**, Bluetooth 5.3 *(Lenovo)*. Bluetooth works; Wi-Fi works in Windows, not detected in the one Fedora live run, see "Laptop check"
- Ports: 2x Thunderbolt 4 / USB4 (USB-C, PD 3.0, DP 2.1), 2x USB-A 5 Gbps (one Always On), HDMI 2.1 (up to 4K60), audio
- Ethernet: none built in *(PSREF)*, needs a USB-C adapter. Lenovo's page says "Wired Network 1x", maybe an adapter
  in the order; check what came with it.
- Camera: 5 MP + IR, privacy shutter, 2 microphones, Human Presence Detection *(Lenovo)*
- Audio: Realtek ALC3287, 2x 2 W speakers *(PSREF)*
- Battery: sealed, **54.7 Wh** design *(check)*
- Power: USB-C, 45 W or 65 W, rapid charge needs 65 W *(PSREF)*
- Security: discrete TPM 2.0. Fingerprint reader in the power button and smart-card reader are options; check whether
  this unit has them *(PSREF)*
- Size: 301.7 x 214.8 x 15.95 mm, from about 1.12–1.17 kg depending on battery; CFRP or carbon hybrid lid *(PSREF)*
- No pen support *(PSREF)*. Lenovo's page says "Convertible Notebook", but 21LU/21LV is the clamshell; the
  convertible is the X13 2-in-1 Gen 5 (21LW/21LX).
- Original OS: Windows 11 Pro

### Warranty
**In warranty** as of 2026-11-03, "< 19 months remaining", so until about mid 2028 (exact date not on the page).
3 years Premier next business day, includes sealed battery replacement and CO2 offset *(Lenovo)*.
End of service 2030-10-13.

Links:
- Lenovo PSREF: https://psref.lenovo.com/Detail/ThinkPad/ThinkPad_X13_Gen_5
- Spec sheet PDF: https://psref.lenovo.com/syspool/Sys/PDF/ThinkPad/ThinkPad_X13_Gen_5/ThinkPad_X13_Gen_5_Spec.PDF
- Hardware maintenance manual (covers 21LU/21LV, section "M.2 solid-state drive, bracket and thermal pad"):
  https://www.manualslib.com/manual/3420500/Lenovo-Thinkpad-X13-Gen-5.html
- Arch Wiki: https://wiki.archlinux.org/title/Lenovo_ThinkPad_X13_Gen_5

## SSDs
Decided 2026-11-03: **keep the factory Samsung in this laptop.** Opening it was given up: with all screws loose the base
cover stayed held in the battery area by a plastic hook not seen in online videos, and the battery seemed to lift with
the cover. Not identified, maybe a previous repair. Don't force it or use heat; ask Lenovo or a repair shop if it ever
has to be opened (battery service, for instance).

| | Intel from the old salem | Factory disk |
|---|---|---|
| Capacity | 1 TB | 512 GB |
| Model | Intel SSDPEKKF010T8L (Pro 7600p family), 2018 | Samsung MZVL8512HDLU-00BLL (PM9C1a) |
| Interface | PCIe 3.0 x4 | PCIe 4.0 x4 |
| Rated read/write | up to 3.2 / 1.6 GB/s | up to about 5.5 / 5.0 GB/s (from a reseller, no Samsung sheet found for this size) |
| Wear | 2 %, 33.2 TB written, 932 h | 1 %, 4.8 TB written, 347 h |
| Contents | whole EndeavourOS install | Windows 11 Pro |

- Space should be fine: tukey, with the same synced folders, uses 137 GB. Check the Intel's real usage before copying.
- The Intel stays as it is until the new install has proven itself, then serves as a spare or external disk.

### Factory SSD (check 2026-11-03)
- SAMSUNG **MZVL8512HDLU-00BLL**, 512 GB, PM9C1a according to a retailer listing, DRAM-less (uses host memory)
- SMART OK, 1 % used, short self-test passed
- 347 power-on hours, 4.8 TB written, 31 unsafe shutdowns

### Intel SSD (SMART 2026-10-22)
- INTEL **SSDPEKKF010T8L** (Pro 7600p family), 1.02 TB, serial `PHHP9355005J1P0D`, firmware L12P, NVMe 1.3, 512 B LBA
- Health PASSED, 2 % used, spare 100 %, 0 media/data-integrity errors, 0 error-log entries
- 932 power-on hours, 1961 power cycles, 33.2 TB written / 38.1 TB read, 116 unsafe shutdowns
  (a healthy machine accumulates these too, so the counter says little on its own)
- Intel rates the 1 TB model at 576 TBW
- Composite temperature ~37 °C idle, warning 75 °C / critical 80 °C

## Laptop check (2026-11-03, Fedora KDE live USB)
Reports are on the stick in `reports/`. 19 passed, 1 warning, 1 failed.

**Failed: no Wi-Fi card, but only under Linux.** In Windows it works and sees networks around it, so the card is fine.
**Wi-Fi on Linux is still unproven.** The check's NetworkManager saw no Wi-Fi device and the report doesn't say why. Windows had written to the stick 6 minutes earlier,
so a card left in a bad state until a full power-off is one possible cause. Test it on a live USB before overwriting
the Samsung: power off fully (hold the power button for 10 s), boot the stick and look at `sudo dmesg | grep -i iwl; rfkill list; nmcli device`.
2026-11-05, EndeavourOS live USB: same. `lspci` lists the card and nothing is rfkill-blocked, but iwlwifi's probe fails with **error -110** (timeout),
so the card doesn't answer while starting up. Things to try: PCI remove + rescan, Windows Fast Startup off + cold boot without the charger,
BIOS → Config → Power → Disable Built-in Battery.

**Warning: unplugging not detected.** The charger stayed in during that step (or the script missed it), so these did not
run: runtime on battery and charging after plugging back in. Charging itself is fine, it went from 33 to 34 % on the
charger at the start.

Passed:
- Battery: 55.2 of 54.7 Wh = 100 %, 27 cycles
- Speakers (left, right, clean), microphone, webcam, screen, all keys, touchpad: my answers on the test page
- CPU, 2 min full load: 2939 single-core, 9134 multi-core sustained, 9365 best, so it holds 97 %. Fan up to 4566 RPM.
- Temperature: peak 101 °C, 67 °C average over the last minute, clock 1567 MHz, 4860 throttle events. Over the 97 °C
  in my checklist, but only as a short spike at the start: settling at 67 °C means the 15 W power limit sets the clock,
  not the cooling. The old salem did the same (97 °C at first, then 65–70 °C).
- RAM: about 75 % of memory written and verified without errors. Not a substitute for memtest86+.
- Disk: short self-test passed. Kernel log: no hardware errors.

Not tested: USB ports, HDMI, headphone jack, long-term stability, fingerprint reader. Touchscreen not recorded.

## Moving the install
Not done yet. Copying files beats `dd`: 1 TB doesn't fit on 512 GB, and it lets swap grow to fit the 32 GB RAM.
Needs an M.2 NVMe to USB-C enclosure (NVMe-capable, not SATA-only) for the Intel. Boot an EndeavourOS live USB on this
laptop and leave the Intel unchanged, so it stays the fallback.

Before overwriting the Samsung:
1. Windows is erased by this. Keep an image on an external disk (for example Clonezilla) if I want it back, for
   warranty or resale.
2. BIOS (F1): **Secure Boot was already off** when I got it (2026-11-03) and has to stay off, since systemd-boot here
   is unsigned. Check there is no supervisor password, the Absolute Persistence Module state and that AMT is
   unprovisioned (vPro, and the S9 model number looks like a company order).

The copy:
1. Partition the Samsung like the Intel: ESP 2 GB, LUKS → btrfs (`@`, `@home`, `@cache`, `@log`), LUKS → swap about 34 GB.
2. Copy the ESP and each subvolume with `rsync -aHAX --numeric-ids`, the Intel mounted read-only.
3. The new partitions have new UUIDs. Update `/etc/fstab`, `/etc/crypttab`, `/etc/kernel/cmdline` and
   `/etc/dracut.conf.d/` (`calamares-luks.conf`, resume device). Don't give them the old btrfs UUID: that breaks while
   both disks are attached.
4. In a chroot: `bootctl install`, then `reinstall-kernels` so the boot entries and initrd match the new UUIDs and this
   hardware.
5. Unplug the Intel, reboot, check `hostname`, Tailscale, Syncthing. If it fails, try the "fallback" boot entry.

Then set or check what stayed with the old board:
- [ ] Battery charge limits (KDE Settings → Power)
- [ ] BIOS settings: sleep state, Fn/Ctrl swap (was swapped), VT-x (was off), Thunderbolt security
- [ ] Fingerprint, if fitted: re-enroll
- [ ] Hibernate: test it with a full session
- [ ] Audio and webcam on Arch. Both worked on the Fedora live USB; audio needs SOF (`sof-firmware` is on tukey, check
      here). Lenovo warns that Human Presence Detection may not work on Linux
- [ ] Sleep drain on battery, and whether package C-states go deep (`powertop`)
- [ ] `fwupdmgr get-updates`, BIOS update
- [ ] Replace *(PSREF)* values above with measured ones: `sudo dmidecode`, `lspci -nn`, `lsusb`, panel
- [ ] Battery runtime and charging after unplugging, not covered by the check
- [ ] memtest86+ once, while the RAM is under warranty

## System setup (on the SSD, from the old salem, as of 2026-10-22)
- EndeavourOS + KDE Plasma (Wayland)
- Boot: systemd-boot + dracut (EndeavourOS default); kernel parameters live in `/etc/kernel/cmdline`
- Disk: nvme0n1p1 `/efi`, p2 LUKS → btrfs (`@`, `@home`, `@cache`, `@log`), p3 LUKS → swap (17 GB, used for hibernate)
- Kernel cmdline: `nvme_load=YES nowatchdog rootflags=subvol=/@ rd.luks.uuid=… resume=/dev/mapper/luks-bee30bca-…`
  (LUKS root `e168bb76-63d1-40b9-9027-c7bc81f65a1d`, LUKS swap `bee30bca-dbde-46ae-a2ce-c9369fde4622`)
- ESP partition UUID `b1d4c47f-28f1-4849-91d3-09139124fc52`
- Machine-id `149c5f49415f445c9851570a4d75c48e`
- Power: power-profiles-daemon (KDE switches it: balanced on AC, power-saver on battery)
- Backup: none yet

### Video decode — gotcha
- `vainfo` **failed** on the host (`vaInitialize failed, error -1`): `intel-media-driver` was not installed, so the host
  had no VAAPI driver.
- Therefore the Arch-packaged **Firefox and Chromium decode video in software**. The
  `org.freedesktop.Platform.VAAPI.Intel` Flatpak extension is present but only serves Flatpak apps.
- In `chrome://gpu`, trust the decoder list under **"Video Acceleration Information"**,
  not the "Video Decode: Hardware accelerated" feature line, which lies.

## Desk peripherals (as of 2026-10-22, for reference)
Microchip USB4206/USB4216 hub chain, Realtek RTL8153 Gigabit Ethernet, Logitech Brio 500 webcam,
Keychron K8 Pro keyboard, Logitech G102/G203 mouse, SteelSeries Arctis Nova Pro Wireless headset,
Dell monitor (DRM `VEN_DEL&DEV_427C`, serial F2H2H34).

## If the board ever has to be replaced
Hostname, Tailscale identity, data and kernel args travel **with the SSD**, while BIOS settings and passwords, UEFI
boot entries, fingerprint enrollments, battery thresholds, Wi-Fi MAC and the serial stay **with the board**. A board
with stale NVRAM entries falls back to `\EFI\BOOT\BOOTX64.EFI`, so check that this file exists on `/efi` before
pulling the disk (`sudo bootctl install` if it is missing).

## Health log
- 2026-10-22: Intel SSD 2 % used, 932 h (still in the X1 Yoga)
- 2026-11-03: battery 55.2 of 54.7 Wh = 100 %, 27 cycles. Samsung factory SSD 1 %, 347 h, 4.8 TB written. BIOS 1.19.

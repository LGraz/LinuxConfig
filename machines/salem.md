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

Identity (dmidecode, 2026-10-22):
- System serial (sticker) **PF1YNR62**, UUID `f952bf4c-23d5-11b2-a85c-8494ded6717f`
- SKU `LENOVO_MT_20QG_BU_Think_FM_ThinkPad X1 Yoga 4th`, machine-id `149c5f49415f445c9851570a4d75c48e`
- SMBIOS 3.1.1, SPI ROM 32 MiB
- Panel: BOE **NV140QUM-N53** (the UHD eDP panel; spare-part searches need this number)

Links:
- Arch Wiki: https://wiki.archlinux.org/title/Lenovo_ThinkPad_X1_Yoga_(Gen_4)
- Lenovo PSREF: https://psref.lenovo.com/Product/ThinkPad/ThinkPad_X1_Yoga_4th_Gen

## System setup
- BIOS N2HET77W (1.60, 2024-02-06), probably final
- Boot: systemd-boot + dracut (EndeavourOS default); kernel parameters live in `/etc/kernel/cmdline`
- Disk: nvme0n1p1 `/efi`, p2 LUKS → btrfs (`@`, `@home`, `@cache`, `@log`), p3 LUKS → swap (17 GB, used for hibernate)
- Kernel cmdline (2026-10-22): `nvme_load=YES nowatchdog rootflags=subvol=/@ rd.luks.uuid=… resume=/dev/mapper/luks-bee30bca-…`
  (LUKS root `e168bb76-63d1-40b9-9027-c7bc81f65a1d`, LUKS swap `bee30bca-dbde-46ae-a2ce-c9369fde4622`)
- Battery charge limits: 70–80 % (set in KDE Settings → Power; stored in the ThinkPad firmware)
- Power: power-profiles-daemon (KDE switches it: balanced on AC, power-saver on battery)

### Firmware inventory (fwupd, 2026-10-22)
| Component | Version |
|---|---|
| System firmware / BIOS (N2HET77W) | 1.60 (fwupd capsule "65596", UEFI resource 26403) |
| Embedded controller (EC) | 1.26 |
| Intel ME | 12.0.93.2331 |
| TPM | 73.64.17568.6659 |
| Thunderbolt host controller | 47.00 |
| Synaptics "Prometheus" fingerprint reader | 10.01.3478575 (IOTA config 0021) |
| NVMe SSDPEKKF010T8L | L12P |
| UEFI dbx | 20230501 |

- CPU microcode revision 0x100 (family 6, model 0x8E, stepping C).
- The internal SPI controller reports "device firmware has been locked", so no fwupd flashing of
  the BIOS region; updates would have to come as a Lenovo capsule.

### BIOS settings of record (think-lmi, 2026-10-22)
Read/write them without rebooting via `/sys/class/firmware-attributes/thinklmi/attributes/`.
- A **BIOS supervisor (Admin) password is set** (`Admin is_enabled=1`, power-on password off) and
  `BIOSPasswordAtBootDeviceList=Enable`, so **F12 / F1 ask for the password** while a normal boot
  does not. Writes through think-lmi need authentication.
- `SecureBoot=Disable`, `SecureRollBackPrevention=Disable`
- `SleepState=Linux` (s2idle; the "Linux" option is the right one for this machine)
- `VirtualizationTechnology=Disable`, `VTdFeature=Disable` — hence no IOMMU, legacy xAPIC, and
  `x86/cpu: VMX (outside TXT) disabled by BIOS` in the log. Enable VT-x if you ever want VMs.
- `ThunderboltSecurityLevel=UserAuthorization`, `PreBootForThunderboltDevice=Disable`,
  `KernelDMAProtection=Disable`
- `AdaptiveThermalManagementAC=MaximizePerformance`, `…Battery=Balanced`, `SpeedStep=Enable`,
  `CPUPowerManagement=Automatic`
- `TotalGraphicsMemory=256MB`, `BootDisplayDevice=LCD`, `SharedDisplayPriority=USBTypeC`
- `BootMode=Quick`, `BootOrder=USBCD:USBFDD:NVMe0:NVMe1:HDD0:HDD1:USBHDD:PXEBOOT::LENOVOCLOUD`
- `FnCtrlKeySwap=Enable` (Fn and left Ctrl are swapped in firmware)
- Fingerprint pre-desktop auth enabled; enrollments live on the Synaptics sensor, not on the disk

### Storage (SMART, 2026-10-22)
- INTEL **SSDPEKKF010T8L** 1.02 TB, serial `PHHP9355005J1P0D`, firmware L12P, NVMe 1.3, 512 B LBA
- Health PASSED, 2 % used, spare 100 %, 0 media/data-integrity errors, 0 error-log entries
- 932 power-on hours, 1961 power cycles, 33.2 TB written / 38.1 TB read, 116 unsafe shutdowns
  (a healthy machine accumulates these too, so the counter says little on its own)
- Composite temperature ~37 °C idle, warning 75 °C / critical 80 °C

### Thermals and power (measured 2026-10-22)
- Idle: CPU/ACPI ~56 °C, package 56–80 °C depending on the moment, **fan 0 RPM** (it really does
  stop), PCH ~58 °C, WiFi ~44 °C
- 10 min `stress-ng --cpu 0 --vm 2 --vm-bytes 60% --verify`: ~97 °C for the first seconds, then a
  steady **65–70 °C at ~3890 RPM** (fan maximum). Package high/crit = 100 °C, never reached.
- Throttle counters rose by ~1570 package events during those 10 min. Normal for a 15 W U-chip at
  full load; not a cooling defect.
- `fan1: 65535 RPM` appears for one sample when the fan spins up — a sensor artefact, ignore it.

### Video decode — gotcha
- `vainfo` **fails** on the host (`vaInitialize failed, error -1`): `intel-media-driver` is not
  installed, so the host has no VAAPI driver.
- Therefore the Arch-packaged **Firefox and Chromium decode video in software**. The
  `org.freedesktop.Platform.VAAPI.Intel` Flatpak extension is present but only serves Flatpak apps.
- In `chrome://gpu`, trust the decoder list under **"Video Acceleration Information"** (empty here),
  not the "Video Decode: Hardware accelerated" feature line, which lies.
- Consequence: salem has **never exercised the GPU media engine**. Installing `intel-media-driver`
  would be a new, untested code path — worth knowing before blaming it for anything.

### Benign kernel messages (seen at every boot, don't chase them)
`MMIO Stale Data CPU bug present and SMT on` · `x86/cpu: VMX (outside TXT) disabled by BIOS` ·
`SGX disabled or unsupported by BIOS` · `virt/tdx: TDX not supported` ·
`hpet_acpi_probe: no address or irqs in _CRS` · `ENERGY_PERF_BIAS: Set to 'normal'` ·
dozens of `iwlwifi … WRT: Overriding region id N` · `resource sanity check … snb_uncore_imc_init_box
… mapping multiple BARs` · `i801_smbus: SMBus is busy, can't use it!` ·
`spi-nor spi0.0: supply vcc not found, using dummy regulator` ·
`uvcvideo: Failed to set UVC probe control : -32` (Brio 500) ·
`Bluetooth: hci0: HCI LE Coded PHY feature bit is set, but its usage is not supported` ·
`skl_hda_dsp_generic: ASoC: Parent card not yet available, widget card binding deferred` ·
`hid-sensor-hub: hid_field_extract() called with n (192) > 32!` ·
`kdeconnectd uses wireless extensions which will stop working for Wi-Fi 7 hardware`

### Docked peripherals (as of 2026-10-22, for reference)
Microchip USB4206/USB4216 hub chain, Realtek RTL8153 Gigabit Ethernet, Logitech Brio 500 webcam,
Keychron K8 Pro keyboard, Logitech G102/G203 mouse, SteelSeries Arctis Nova Pro Wireless headset,
Dell monitor (DRM `VEN_DEL&DEV_427C`, serial F2H2H34). Internal USB: Chicony camera `04f2:b67c`,
Synaptics Prometheus fingerprint `06cb:00bd`, Intel Bluetooth `8087:0aaa`.

## Diagnostic history
- 2026-10-21 … 10-24: salem served as the **healthy control** while diagnosing hard freezes on a
  second, identical X1 Yoga Gen 4 (same MTM, same BIOS, since scrapped because of a defective
  mainboard — the RAM was soldered). The same diagnostic script ran on both machines, and salem came
  out clean in every comparison: SMART, battery health, idle and load thermals, throttle behaviour,
  10-min `stress-ng --cpu 0 --vm 2 --vm-bytes 60% --verify`, firmware versions.
- **memtest86+ v9.00, run overnight 2026-10-24/25: salem passed with no errors.** The other machine did report
  errors, which is what settled that diagnosis. So salem's RAM has a clean full-coverage test on
  record — worth remembering, since the modules are soldered and could never be swapped.
  The stick was made from memtest.org's "Linux ISO (64 bits)" (`mt86plus_9.00_x86_64.iso.zip`,
  SHA256 verified) `dd`-ed to the whole device; boot it with F12 (Secure Boot is already off, but the
  BIOS password is needed to reach the boot menu). v9 runs all tests on all cores by default.
- If salem's board ever has to be replaced: hostname, Tailscale identity, data and kernel args travel
  **with the SSD**, while BIOS settings and passwords, UEFI boot entries, fingerprint enrollments,
  battery thresholds, Wi-Fi MAC and the serial stay **with the board**. A board with stale NVRAM
  entries falls back to `\EFI\BOOT\BOOTX64.EFI`, so check that this file exists on `/efi` before
  pulling the disk (`sudo bootctl install` if it is missing).

## Health log
- 2026-10-22: battery 76.97 % of design (39.26/51.01 Wh), 374 cycles; SSD 2 % used, 932 h
- 2026-10-24: battery at 78 % of design capacity (39.8/51.0 Wh), 375 cycles

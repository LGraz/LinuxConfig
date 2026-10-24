# acer — Acer Swift 3 SF315-52 (model no. N17P6)

Hostname `acer`. 15.6" clamshell from 2018 (Intel 8th gen, Kaby Lake Refresh), aluminium chassis.
N17P6 is the regulatory model number shared by SF315-52 (Intel graphics only) and SF315-52G (+ NVIDIA MX150).

This page was written from research while the laptop was offline: Acer/retailer spec sheets plus
19 real Linux probes of SF315-52 units (linuxhw DMI + dmesg dumps, see links). Where configs differ, all
variants are listed. Run the checklist at the bottom once the machine is online and replace them with the actual values.

## Hardware
- Mainboard: Acer "Erdinger_KL" (DMI board name), board code ER5EA
- Chipset: Intel Sunrise Point-LP (100-series PCH-LP, on-package with the CPU)
- CPU (one of): Core i3-8130U (2C/4T), i5-8250U (4C/8T, 1.6–3.4 GHz), i7-8550U (4C/8T, 1.8–4.0 GHz); 15 W,
  CPUID family 6 model 0x8e stepping 0xa (sig 0x806ea); probes: 15x i5-8250U, 4x i7-8550U
- GPU: Intel UHD 620 (i915); SF315-52G adds NVIDIA GeForce MX150 2 GB GDDR5 (Pascal, Optimus/PRIME)
- RAM: DDR4, 2x SO-DIMM (ChannelA-DIMM0, ChannelB-DIMM0), runs at 2400 MT/s (CPU limit, faster modules downclock)
  - factory 4 or 8 GB (SK Hynix HMA81GS6AFR8N-UH 8 GB, Kingston ACR26D4S9S1ME-4 4 GB seen)
  - upgradeable: probes show owner-added Crucial 16 GB, G.Skill 8 GB, Samsung 2x8 GB; Acer says max 16 GB,
    the CPU supports 32 GB (2x16 GB likely works, unverified)
- Storage: 1x M.2 2280 (SATA or PCIe NVMe) + 1x 2.5" SATA bay
  - M.2 NVMe sits on PCIe root port 00:1d.0, M.2 SATA shows up as ata3, the 2.5" bay as ata2
  - shipped configs seen: SK hynix HFS256G39TND-N210A (M.2 SATA 256 GB), Kingston NVMe [2646:5008],
    Toshiba MQ04ABF100 1 TB HDD in the bay, some with Intel Optane Memory 16 GB [8086:2522] + HDD (Intel RST, see Linux notes)
  - SSD-only configs may lack the 2.5" cable/caddy
- Display: 15.6" 1920x1080 IPS, matte, 60 Hz, non-touch, eDP 30-pin (FHD TN and UHD panels exist as spare parts); reviews: rather dim
- WiFi: Intel Dual Band Wireless-AC 7265 rev D [8086:095a], 2x2 802.11ac (max 867 Mbit/s), M.2 2230 card, iwlwifi/iwlmvm,
  firmware `iwlwifi-7265D-29.ucode`; on root port 00:1c.0 (PCIe 2.5 GT/s x1)
- Bluetooth: Intel (on the 7265 card, USB) [8087:0a2a], btusb, firmware `intel/ibt-hw-37.8.10-fw-*.bseq`
- Audio: Intel HDA [8086:9d71] with Realtek ALC256 codec (snd_hda_intel), stereo speakers (reviews: average), 3.5 mm combo jack, HDMI audio
- Touchpad: I2C HID (i2c_hid_acpi + hid_multitouch, on Intel Serial IO I2C [8086:9d60/9d61]), two vendors:
  Synaptics `SYNA7DB5:00 06CB:CD41` (most probes) or ELAN `ELAN0501:00 04F3:3091`
- Keyboard: PS/2 (AT Translated Set 2), backlit; hotkeys via acer_wmi ("Acer WMI hotkeys", "Acer Wireless Radio Control")
- Fingerprint: EgisTec Touch Fingerprint Sensor [1c7a:0570] (USB, palmrest), libfprint driver `egis0570`
- Webcam: Chicony "HD WebCam" [04f2:b5c5], 720p, uvcvideo, no IR
- Card reader: Realtek USB2.0-CRW [0bda:0129] (rtsx_usb_sdmmc), full-size SD
- TPM: TPM 2.0 (Intel PTT firmware TPM, ACPI TPM2 table)
- Ports: 1x USB-C 3.1 Gen 1 (5 Gbit/s, no Thunderbolt; DP-alt/charging not confirmed), 2x USB-A 3.1 Gen 1, 1x USB-A 2.0,
  HDMI, 3.5 mm combo jack, SD reader, DC-in, Kensington lock; no Ethernet
- Battery: Acer AC17B8K, 4-cell Li-ion (4ICP5/57/81), 15.2 V, 3220 mAh, 48 Wh
- Power: 45 W Acer adapter (19 V), barrel 3.0/1.1 mm (65 W Acer adapter also fits)
- Size/weight: 359 x 243 x 16.9 mm, ~1.8 kg

### PCI devices (lspci -nn, identical on all probes unless noted)
| Address | ID | Device |
|---|---|---|
| 00:00.0 | 8086:5914 | Host bridge (Kaby Lake R, U quad core) |
| 00:02.0 | 8086:5917 | UHD Graphics 620 |
| 00:08.0 | 8086:1911 | Gaussian Mixture Model |
| 00:14.0 | 8086:9d2f | USB 3.0 xHCI |
| 00:14.2 | 8086:9d31 | Thermal subsystem |
| 00:15.0/.1 | 8086:9d60/9d61 | Serial IO I2C #0/#1 (touchpad) |
| 00:16.0 | 8086:9d3a | CSME HECI (Intel ME) |
| 00:17.0 | 8086:9d03 / 282a | SATA, AHCI mode / RAID (RST) mode |
| 00:1c.0 | 8086:9d15 | PCIe root port → WiFi |
| 00:1d.0 | 8086:9d18 | PCIe root port → M.2 NVMe (only present with an NVMe drive) |
| 00:1f.0 | 8086:9d4e | LPC/eSPI |
| 00:1f.2 | 8086:9d21 | PMC |
| 00:1f.3 | 8086:9d71 | HD Audio |
| 00:1f.4 | 8086:9d23 | SMBus |
| 01:00.0 | 8086:095a | Wireless-AC 7265 |
| 02:00.0 | varies | NVMe SSD (if any) |
| (52G only) | 10de:… | GeForce MX150 |

### USB devices (lsusb)
| ID | Device |
|---|---|
| 8087:0a2a | Intel Bluetooth |
| 1c7a:0570 | EgisTec fingerprint |
| 0bda:0129 | Realtek card reader |
| 04f2:b5c5 | Chicony HD WebCam |

## Firmware
- AMI Aptio V UEFI, UEFI only (no CSM), 8 MB SPI flash, Intel ME 11.8
- BIOS versions seen: V1.04 (2018-06-22), V1.07 (2018-09-28), V1.08 (2018-12-21); 1.08 is the newest known, so probably final
- BIOS updates only as Windows .exe from Acer support (not on LVFS/fwupd)
- Never flash an extracted capsule or downgrade with a SPI programmer: it is a partial image (EC + ME), bricks reported (winraid)
- Keys: F2 = BIOS setup, F12 = boot menu (enable "F12 Boot Menu" in BIOS Main first)
- Secure Boot (Acer quirk): set a Supervisor password first, then either disable Secure Boot or whitelist the
  bootloader via Security → "Select an UEFI file as trusted for executing"
- Sleep: ACPI S0 S3 S4 S5, so real S3 deep sleep works

## Linux notes / known issues
- AER log spam: almost all probes log hundreds of `pcieport 0000:00:1c.0: AER: Corrected error ... RxErr` (the WiFi root port).
  Corrected errors, harmless, but they flood the journal. The firmware (FADT) forbids the kernel from touching ASPM, so
  `pcie_aspm=...` does nothing; silence it with kernel parameter `pci=noaer`
- Intel RST / RAID mode: units shipped with Optane + HDD run SATA in RAID mode; Linux then hides the NVMe
  (`ahci: Found 1 remapped NVMe devices. Switch your BIOS from RAID to AHCI mode`). Set SATA mode to AHCI in BIOS before installing
- Touchpad: BIOS option Touchpad "Basic" (PS/2 mouse, no gestures) vs "Advanced" (I2C HID, needed for gestures). If it dies
  after resume: `sudo modprobe -r hid_multitouch && sudo modprobe hid_multitouch`
- Fingerprint: install `fprintd` (libfprint has the egis0570 driver), enroll in KDE Settings → Users
- `thermal_zoneN: failed to read out thermal zone (-61)` at boot: harmless
- MX150 (SF315-52G only): Pascal is dropped by current NVIDIA drivers, needs the legacy 580xx driver (AUR) or nouveau;
  simplest is to leave it off and use the Intel GPU
- No known battery charge-limit support

Links:
- Notebookcheck: https://www.notebookcheck.net/Acer-Swift-3-SF315-52-58HG.316416.0.html
- Linux probes (DMI): https://github.com/linuxhw/DMI/tree/master/Notebook/Acer/Swift/Swift%20SF315-52
- Linux probes (dmesg): https://github.com/linuxhw/Dmesg/tree/main/Notebook/Acer/Swift/Swift%20SF315-52
- linux-hardware.org: https://linux-hardware.org/?view=computers&vendor=Acer&model=Swift+SF315-52
- Spare parts: https://www.ipc-computer.eu/acer/notebook/swift-serie/swift-3-sf315-52/
- BIOS flashing thread: https://winraid.level1techs.com/t/request-bios-extract-and-flash-by-efi-shell-acer-sf315-52/35960
- Acer support (drivers, BIOS, manual by serial number): https://www.acer.com/support

## System setup
TODO once online.

## To check when it's online
- `sudo dmidecode -t system -t bios -t memory`: exact SKU (SF315-52-xxxx), BIOS version, RAM modules and free slot
- `lspci -nn`, `lsusb`: which variant (MX150? NVMe or SATA? SATA in AHCI mode?)
- `lsblk -o NAME,MODEL,SIZE,TRAN`: drives
- `cat /proc/cpuinfo | grep -m1 'model name'`
- `upower -i $(upower -e | grep BAT)`: battery health (design vs full capacity, cycles)
- `sudo libinput list-devices | grep -A1 Touchpad`: Synaptics or ELAN
- `journalctl -k -b | grep -c AER`: AER spam present?

Old setup fixes (sound, keyboard model, sleep disabled): `installation-scripts/acer.sh`

## Health log

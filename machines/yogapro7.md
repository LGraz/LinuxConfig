# yogapro7 — Lenovo Yoga Pro 7 14APH8 (Type 82Y8)

14.5" aluminium clamshell creator laptop from 2023 (AMD Ryzen 7000 "Phoenix" + NVIDIA Ada Lovelace).
Note: despite the "Yoga" branding, the **Yoga Pro 7** line is a regular 180° clamshell, not a 360°
convertible.

Identifiers (from Lenovo support / spec lookup):
- Serial number: **YX07EKST**
- Machine Type Model (MTM): **82Y8002BMZ** (`82Y8` = Yoga Pro 7 14APH8; `MZ` = Switzerland region,
  so Swiss keyboard layout and FR/IT/EN/DE factory OS image)
- GTIN / EAN: **197528708676**
- Warranty: **Out of warranty** (shipped to Switzerland, 2Y Depot warranty started **2023-08-18**,
  expired **Oct 2025**; 3M Premium Care expired 2024-01-16; model End of Service is 2029-07-05)

**This page was written while the machine was offline for troubleshooting/repair — see the diagnostic
and probe checklists at the bottom once it boots.** Specs below combine the exact factory BOM for
serial `YX07EKST` / MTM `82Y8002BMZ` with the Lenovo PSREF for Type `82Y8` *(marked PSREF)* and
community Linux probes for the 14APH8.

## Hardware
- CPU: **AMD Ryzen 7 7840HS** (Zen 4 "Phoenix", 8C/16T, 3.8 GHz base / up to 5.1 GHz boost, 8 MB L2,
  16 MB L3, 35–54 W cTDP, TSMC 4 nm)
- GPU (hybrid / NVIDIA Advanced Optimus / PRIME):
  - iGPU: **AMD Radeon 780M** (`1002:15bf`, Phoenix1, RDNA 3, 12 CUs @ up to 2700 MHz), driver `amdgpu`
  - dGPU: **NVIDIA GeForce RTX 4050 Laptop GPU** (`10de:28a1`, AD107M, **6 GB GDDR6**, 96-bit,
    Lenovo Studio-validated, ~55–60 W TGP in this chassis)
- RAM: **16 GB LPDDR5x-6400, soldered** (dual-channel, 8x 16-bit channels). **Not upgradeable, no
  SO-DIMM slots**: as on `salem` and `tukey`, a RAM fault means a mainboard fault. Note that the
  Radeon 780M carves its VRAM (typically 512 MB–2 GB, configurable as UMA Frame Buffer Size in BIOS)
  out of this 16 GB.
- Disk: **1 TB PCIe 4.0 x4 NVMe SSD** (factory spec: `1x 1 TB SSD PCIe`). PSREF lists **1x M.2 slot**
  accepting M.2 2242 or M.2 2280 PCIe 4.0 x4 (exact OEM drive model/serial/SMART to be read on the
  machine — Lenovo typically fits Samsung PM9A1/PM9B1, SK hynix PC801, Micron 2400/3400, or Western
  Digital SN740/SN810).
- Display: **14.5" 3K (3072x1920) 16:10 IPS**, 400 cd/m², **120 Hz** (dynamic 60/120 Hz), 100 % DCI-P3,
  anti-glare (matte) on `82Y8002BMZ` *(PSREF — a glossy AGC Dragontrail glass touch 3K variant also
  exists in the 82Y8 family; confirm touch device presence in `libinput`)*, Eyesafe Certified 2.0,
  Dolby Vision, factory TCON color calibration.
- WiFi/BT: **Wi-Fi 6E 2x2 802.11ax + Bluetooth 5.1+** (PSREF: BT 5.3 hardware). M.2 2230 slot
  (socketed, upgradeable to Intel AX210 if desired). Lenovo ships either:
  - **MediaTek MT7922 / AMD RZ616** (PCI `14c3:0616`, driver `mt7921e`, BT USB `0489:e0d8` Foxconn), or
  - **Realtek RTL8852CE** (PCI `10ec:c852`, driver `rtw89_8852ce`, BT USB `0bda:c852` / `0489:…`)
- Audio: AMD ACP (Audio CoProcessor / Pink Sardine) + HD-Audio controller with **Realtek ALC287** codec,
  **4 stereo speakers** (2x 2 W tweeters + 2x 2 W woofers, Dolby Atmos, Smart AMP), **4-mic array**
  (via AMD ACP PDM digital mic controller `snd_soc_acp6x_mach` / `snd_acp_pci`), 3.5 mm combo jack,
  HDMI audio (via NVIDIA/AMD HDA).
- Camera: **1080p FHD IR + RGB hybrid webcam** (typically Luxvisions Innotech `30c9:00a8` or Chicony
  on USB), **ToF (Time-of-Flight) human-presence sensor**, and **Electronic Privacy Shutter (E-shutter)**
  controlled by a physical switch on the right side (disconnects/ disables the camera in hardware).
- Input:
  - Backlit 6-row keyboard (Swiss `ch` layout on `-MZ` models), `Fn` multimedia keys
  - Buttonless glass-surface Mylar multi-touch I2C HID touchpad (`75 x 120 mm`, Precision Touchpad)
  - Power button is **on the right side edge** (Yoga style, next to the camera E-shutter switch);
    **Novo button pinhole is on the bottom cover**
- Security hardware: **Firmware TPM 2.0** (AMD fTPM in PSP), IR camera for face unlock (Windows Hello /
  Howdy), **no fingerprint reader** *(PSREF)*.
- Ports:
  - **Left side:**
    - 1x **USB-C (USB4 40 Gbit/s)**, Power Delivery 3.0, DisplayPort 1.4a
    - 1x **USB-C (USB 3.2 Gen 2, 10 Gbit/s)**, Power Delivery 3.0, DisplayPort 1.4a
    - 1x **HDMI 2.1** (up to 4K @ 60Hz)
  - **Right side:**
    - 1x **USB-A (USB 3.2 Gen 1, 5 Gbit/s)**, Always On
    - 1x **3.5 mm headphone/microphone combo jack**
    - Camera E-shutter switch, power button + LED
  - **Bottom cover:** Novo button pinhole
  - **No** RJ-45 Ethernet, **no** SD/microSD card reader.
- Battery: Integrated **73 Wh** 4-cell Li-Polymer (Lenovo part family `L22M4PA0` / `L22C4PA0` /
  `L22D4PA0` / `L22B4PA0`, 15.36 V), supports Rapid Charge Express *(PSREF)*.
- Power: **140 W USB-C slim AC adapter** (20 V / 7 A, 3-pin AC cord) on RTX 4050 models *(PSREF;
  iGPU-only models ship with 100 W)*. Will also charge from standard 65 W / 100 W USB-C PD chargers,
  though heavy CPU+dGPU load may drain or throttle on <100 W.
- Size/weight: 325.5 x 226.49 x 15.6 mm, ~1.49 kg; anodized aluminium top and bottom (Storm Grey or
  Tidal Teal), MIL-STD-810H tested *(PSREF)*.
- Factory OS: Windows 11 Home 64-bit (`Windows 11 Famille 64 (FR:French, IT:Italian, EN:English, DE:German)`).

### Expected DMI / Firmware Identity (to verify with `dmidecode`)
- Vendor: `LENOVO`
- Product Name (`product_name`): `82Y8` (or `82Y8002BMZ`)
- Product Version (`product_version`): `Yoga Pro 7 14APH8`
- Board Name (`board_name`): `LNVNB161216`
- System Serial (`product_serial`): **YX07EKST**
- BIOS Vendor: **Insyde Corp.**
- BIOS Family Prefix: **MLCNxxWW** (e.g. `MLCN28WW`, `MLCN37WW` — do *not* confuse with `M3CN`, which
  is Legion Slim 5). Lenovo publishes updates as Windows `.exe` packages on `pcsupport.lenovo.com`;
  historically **not** pushed via LVFS/`fwupdmgr`.

### Typical PCI devices (`lspci -nn`, from 14APH8 probes — verify on unit)
| Address | ID | Device |
|---|---|---|
| 00:00.0 | 1022:14e8 | AMD Phoenix Root Complex |
| 00:00.2 | 1022:14ea | AMD Phoenix IOMMU |
| 00:02.1/.2/.4 | 1022:14ee | PCIe GPP Bridges (dGPU, NVMe, WiFi) |
| 00:08.1/.2/.3 | 1022:14eb / 14ec / 14ed | Internal PCIe GPP Bridges (GPU, Audio, USB3/USB4) |
| 01:00.0 | **10de:28a1** | **NVIDIA AD107M [GeForce RTX 4050 Max-Q / Mobile]** |
| 01:00.1 | 10de:22be | NVIDIA AD107 High Definition Audio Controller |
| 02:00.0 | *varies* | NVMe SSD controller (PCIe 4.0 x4) |
| 03:00.0 | 14c3:0616 *or* 10ec:c852 | MediaTek MT7922 (RZ616) *or* Realtek RTL8852CE Wi-Fi 6E |
| c4:00.0 | **1002:15bf** | **AMD Phoenix1 [Radeon 780M Graphics]** |
| c4:00.1 | 1002:1640 | AMD Rembrandt/Phoenix Radeon HD Audio Controller |
| c4:00.2 | 1022:15c7 | AMD Phoenix CCP/PSP 3.0 Security Processor (fTPM) |
| c4:00.3/.4 | 1022:15b9 / 15ba | AMD USB 3.1 xHCI controllers |
| c4:00.5 | 1022:15e2 | AMD ACP/ACP3X/ACP6X Audio Coprocessor (DMIC) |
| c4:00.6 | 1022:15e3 | AMD Family 17h/19h HD Audio Controller (Realtek ALC287) |
| c5:00.0 | 1022:14ec | AMD Pink Sardine USB4/Thunderbolt controller |

### Typical USB devices (`lsusb` — verify on unit)
| ID | Device |
|---|---|
| 30c9:00a8 *(or 04f2:…)* | Luxvisions Innotech / Chicony Integrated RGB + IR Camera |
| 0489:e0d8 *(or 0bda:…)* | Foxconn / MediaTek (or Realtek) Bluetooth 5.3 Adapter |

Links:
- Arch Wiki: https://wiki.archlinux.org/title/Lenovo_Yoga_Pro_7_14APH8
- Lenovo PSREF (Type 82Y8): https://psref.lenovo.com/Product/Yoga/Yoga_Pro_7_14APH8
- Lenovo PC Support (search by serial `YX07EKST` or MTM `82Y8002BMZ`): https://pcsupport.lenovo.com/
- Notebookcheck review (14APH8, 7840HS + RTX 4050 + 3K IPS): https://www.notebookcheck.net/Lenovo-Yoga-Pro-7-14APH8-laptop-review-Slim-multimedia-all-rounder-with-Zen4-and-RTX-4050.725216.0.html

---

## Linux notes & known quirks (14APH8 / Type 82Y8)

Unlike ThinkPads (`salem`), consumer Yoga laptops use Lenovo's IdeaPad embedded controller and
InsydeH2O BIOS:
- **Kernel module is `ideapad_acpi` (not `thinkpad_acpi` or `think-lmi`)**:
  - **Battery charge limit ("Conservation Mode"):** limits charge to **~60 %** (or 80 % on newer EC
    revisions). Controlled via `/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode`
    (`1` = on, `0` = off) and exposed directly in KDE Plasma's Power settings via `upower`.
  - **Fn+Q thermal profiles:** exposed as standard ACPI `/sys/firmware/acpi/platform_profile`
    (`low-power` = Battery Saving, `balanced` = Intelligent Cooling, `performance` = Extreme
    Performance), which `power-profiles-daemon` in KDE switches automatically.
- **BIOS / Boot keys:**
  - **F2** (or `Fn+F2`) at boot = BIOS setup
  - **F12** (or `Fn+F12`) at boot = boot menu
  - **Novo button** (pinhole on the right side edge, next to the E-shutter switch — press with a
    paperclip while powered off) = powers on straight into the Novo Menu (BIOS Setup, Boot Menu,
    System Recovery). Very handy if the keyboard or fast-boot prevents catching F2/F12.
- **BIOS settings worth checking:**
  - **Secure Boot:** disable before booting an EndeavourOS/Arch USB stick or `memtest86+`.
  - **Display Mode / Graphic Device:** `Dynamic Graphics` (hybrid AMD iGPU + NVIDIA dGPU, best battery
    life) vs `Discrete Graphics` (dGPU only, if available on this BIOS).
  - **UMA Frame Buffer Size:** `Auto` / `512M` / `1G` / `2G` (VRAM carved out of the 16 GB RAM for the
    Radeon 780M).
  - **Flip to Boot:** powers the laptop on automatically whenever the lid is opened (can be toggled in
    BIOS or sometimes via `ideapad_acpi`).
  - **USB Always On:** controls power on the right-side USB-A port when asleep/off.
- **Audio (4 speakers — 2 tweeters + 2 woofers):**
  - Supported out of the box since Linux **6.6.7+** (ALSA quirk for `ALC287` on `82Y8` routes the
    bass speakers properly). Current Arch kernels (> 7.x on `salem`/`tukey`) need no manual modprobe
    workarounds.
- **Graphics & hybrid GPU (AMD Radeon 780M + NVIDIA RTX 4050):**
  - Unlike `salem` and `tukey` (Intel iGPU only), this machine has **both** `amdgpu` and an Ada
    Lovelace NVIDIA dGPU (`NV197` / `AD107M`).
  - On Arch/EndeavourOS, use **`nvidia-open-dkms`** (or `nvidia-open`, recommended for Turing/Ampere/Ada)
    + `nvidia-utils` + `nvidia-prime`. In hybrid mode, the internal panel and Wayland session run on
    the Radeon 780M (`amdgpu`) while the RTX 4050 sleeps in D3cold until woken via `prime-run` (or
    automatically by Vulkan/games).
  - **VAAPI hardware video decode:** AMD uses Mesa's `libva-mesa-driver` (now part of `mesa` on Arch) —
    Unlike Intel on `salem`/`tukey`, `vainfo` works out of the box once `mesa` is present.
  - **Known Phoenix / `amdgpu` quirk:** older BIOS/kernel combinations could show sporadic white
    screen flashes or visual artifacts on Wayland; the Arch Wiki notes `amd_iommu=off` or
    `amdgpu.sg_display=0` as workarounds if (and only if) this occurs.

---

## Offline troubleshooting & next steps (4-second EC abort diagnosis)

### What we know so far (2026-10-27)
- **Symptom:** Charging LED next to USB-C is **solid white** (on 65 W charger or dock). Pressing either
  the right-side power button or the bottom-cover **Novo pinhole** turns the power LED on for **~4 s**,
  then it clicks off. No fan spin, no LCD backlight, no HDMI/dock video output.
- **What is confirmed healthy:** USB-C PD controller, input MOSFETs, battery charger IC, main 20 V (`B+`)
  rail, `+3.3VALW` / `+5VALW` standby rails, internal battery (> 90 % charged), and the Embedded
  Controller (EC firmware + button sensing).
- **What is failing:** When the EC steps from `S5` to `S3/S0`, a switched rail fails to come up (or
  trips over-current protection due to a short), **or** the AMD Ryzen 7840HS PSP never asserts
  `APU_PWRGD`. At `t = 4.0 s`, the EC watchdog aborts and powers the board back down before the CPU
  ever comes out of reset.

### Step-by-step diagnostic plan (requires Torx T5 screwdriver)

1. **Open bottom cover & perform a true 0 V Battery + CMOS reset**
   - Because the battery is > 90 % charged (solid white LED), the EC and RTC/CMOS have **never actually
     lost power** since the fault occurred.
   - Unplug AC power, remove the **6 Torx T5 screws** on the bottom cover (3 front, 3 rear), and pop the
     cover off starting near the hinges.
   - **Disconnect the main battery cable** from the motherboard (pull horizontally toward the battery)
     and any separate 2-pin RTC/CMOS coin cell if present.
   - Hold the power button for **30–60 s** with both charger and battery disconnected to drain all rails
     to 0 V, then wait 5 minutes.
   - Plug in **only the USB-C charger** (leave the battery unplugged) and press Power.
   - *Note:* First boot after an AMD Phoenix CMOS reset runs LPDDR5x memory training for 30–60 s with a
     black screen — watch whether the power LED stays on past 4 s.

2. **Remove M.2 NVMe SSD and M.2 Wi-Fi card (rule out `+3.3VS` peripheral short)**
   - A heat-damaged NVMe SSD controller or Wi-Fi card capacitor can short the switched `+3.3VS` rail to
     ground while leaving `+3.3VALW` (and the white charging LED) completely fine.
   - Unscrew and remove both the **1 TB M.2 NVMe SSD** and the **M.2 2230 Wi-Fi card**, then press Power
     with both slots empty.
   - Also test the removed 1 TB NVMe SSD in an external USB NVMe enclosure (or another machine) to
     verify if the drive works, read its SMART stats, and back up/inspect its contents.

3. **Thermal ("Finger Test") & visual inspection during the 4-second window**
   - Inspect the PCB around the CPU/GPU VRM phases (grey square coils `PL…`) for cracked/discolored
     DrMOS chips or burnt ceramic/tantalum capacitors.
   - While pressing the power button, feel the heatpipes above the CPU and RTX 4050 and the VRM coils:
     - **Single spot gets burning hot in 2–4 s:** shorted DrMOS or capacitor on a switched rail.
     - **CPU heatpipe warms up slightly:** CPU VRM works; APU is getting power but failing PSP/RAM init.
     - **Everything stays stone cold across multiple presses:** an early switched rail (`+3VS`/`+5VS`/
       `+1.8VS`/RAM) is tripping immediately and halting the power sequence before Vcore turns on.

4. **Multimeter resistance-to-ground check on all coils (if Steps 1–3 don't boot it)**
   - With battery and charger unplugged, measure resistance to ground (Ω mode, black probe on USB shield
     or screw pad, red probe on each grey inductor coil `PL…`):
     - `+3.3VALW`, `+5VALW`, `+1.8V`, RAM (`+1.1V_VDDQ`): should be hundreds of Ω to kΩ (`< 5 Ω` = short).
     - CPU (`VDDCR_VDD` / `VDDCR_SOC`) and RTX 4050 (`NVVDD`): low silicon resistance (`~1–15 Ω` is
       normal; **`0.0–0.4 Ω`** indicates a shorted VRM phase or dead die).
   - Measure voltage on each coil during the 4-second power-on window to identify the exact rail in the
     `S5 -> S0` sequence that stays at `0 V`.

---

## To check when it's online
Once we can boot Linux (live USB or installed system), collect:
- `sudo dmidecode -t system -t baseboard -t bios -t memory`: exact BIOS version (`MLCNxxWW`), board rev,
  RAM chip vendor (Micron / SK hynix / Samsung)
- `lspci -nnk` and `lsusb`: confirm Wi-Fi card (`MT7922` vs `RTL8852CE`), NVMe controller, camera ID
- `lsblk -o NAME,MODEL,SIZE,FSTYPE,UUID` and `sudo smartctl -a /dev/nvme0n1`: exact SSD model, firmware,
  power-on hours, and SMART health
- `upower -i $(upower -e | grep BAT)`: battery model (`L22x4PA0`), cycle count, full vs 73 Wh design capacity
- `sudo libinput list-devices`: touchpad vendor (`ELAN` / `SYNA`) and whether the 3K panel has a touch
  controller
- `journalctl -k -b -p 4`: any ACPI, `amdgpu`, `nvidia`, `mt7921e`/`rtw89`, or NVMe errors

## Health & diagnostic log
- 2026-10-27: Added spec sheet for serial `YX07EKST` / MTM `82Y8002BMZ`. Warranty lookup shows 2Y Depot
  warranty started 2023-08-18 and **expired Oct 2025** (out of warranty).
- 2026-10-27 (initial symptom): Previous owner reported possible "heat death". On a 65 W Lenovo USB-C
  charger (and on a USB-C dock / with external HDMI monitor attached), the charging LED next to the
  USB-C port is **solid white** (battery > 90 % charged, USB-C PD + 20 V main rail + 3.3V/5V standby
  rails healthy). Pressing either the right-side power button or the bottom-cover Novo pinhole lights
  the power LED for **~4 seconds**, then it turns off with **no fan spin and completely dark screen**
  (EC aborts the `S5 -> S0` power sequence before POST).


echo -ne "
-------------------------------------------------------------------------
                    Formating Disk
-------------------------------------------------------------------------
"
# Manual Partitioning
pacman -S --noconfirm --needed gptfdisk
if [[ $PARTITION_STRATEGY == "Dual_Boot" || $PARTITION_STRATEGY == "Manual_Partition" ]]; then
    echo -ne "
    Create the following partitions manually: \n
    1. BIOSBOOT 1M (gdisk code is ef02) \n
    2. EFIBOOT 300M \n
    3. ROOT 10G+ \n\n
    "
    echo "set up partition table on your own, good luck :)"
    echo "DISK = $DISK"
    echo "press any key to start"
    read wait_variable
    lsblk
    cdisk $DISK
    lsblk
    echo "Which partition NUMBER is EFIBOOT (for sda5 the answer is '5')"
    read efiboot_nr
        echo "Which partition NUMBER is ROOT (for sda4 the answer is '4')"
    read root_nr
    partition2=${DISK}${efiboot_nr}
    partition3=${DISK}${root_nr}
fi




echo -ne "
-------------------------------------------------------------------------
                    Use all cores for make and compression  
-------------------------------------------------------------------------
"
nc=$(grep -c ^processor /proc/cpuinfo)
TOTAL_MEM=$(cat /proc/meminfo | grep -i 'memtotal' | grep -o '[[:digit:]]*')
if [[  $TOTAL_MEM -gt 8000000 ]]; then
sed -i "s/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j$nc\"/g" /etc/makepkg.conf
sed -i "s/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -T $nc -z -)/g" /etc/makepkg.conf
fi
echo -ne "
-------------------------------------------------------------------------
                    Setup Language to DE and set locale  
-------------------------------------------------------------------------
"
sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
sed -i 's/^#de_CH.UTF-8 UTF-8/de_CH.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
touch /etc/locale.conf
echo "LANG=en_US.UTF-8" | tee -a /etc/locale.conf
echo "LANGUAGE=en_US" | tee -a /etc/locale.conf
echo "LC_ALL=C" | tee -a /etc/locale.conf
# echo "LC_TIME=de_CH.UTF-8" | tee -a /etc/locale.conf

# Timezone
    ln -sf /usr/share/zoneinfo/Europe/Zurich /etc/localtime
    hwclock —-systohc
    # timedatectl --no-ask-password set-timezone ${TIMEZONE}
    # timedatectl --no-ask-password set-ntp 1
    # localectl --no-ask-password set-locale LANG="en_US.UTF-8" LC_TIME="en_US.UTF-8"
    # localectl --no-ask-password set-locale LANG="en_US.UTF-8" LC_TIME="de_CH.UTF-8"
ln -s /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
# Set keymaps
touch /etc/vconsole
echo "KEYMAP=$KEYMAP" | tee /etc/vconsole
localectl --no-ask-password set-keymap ${KEYMAP}
localectl set-x11-keymap de acer_laptop nodeadkeys

# # Add sudo no password rights
# sed -i 's/^# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers
# sed -i 's/^# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/' /etc/sudoers
# # Remove no password sudo rights
# sed -i 's/^%wheel ALL=(ALL) NOPASSWD: ALL/# %wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers
# sed -i 's/^%wheel ALL=(ALL:ALL) NOPASSWD: ALL/# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/' /etc/sudoers

## pacman:
#Add parallel downloading
sed -i 's/^#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf
#Add color
sed -i 's/^#Color/Color/' /etc/pacman.conf


# skip grub menu
sed -i 's/^GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/' /etc/default/grub
# Dual Boot Grub:
if [[ $PARTITION_STRATEGY == "Dual_Boot" ]]; then
  sed -i 's/^#GRUB_DISABLE_OS_PROBER=false/GRUB_DISABLE_OS_PROBER=false/' /etc/default/grub
fi
grub-mkconfig -o /boot/grub/grub.cfg









echo -ne "
-------------------------------------------------------------------------
                    Install AUR Software
-------------------------------------------------------------------------
"
cd ~
AUR_HELPER=yay
git clone "https://aur.archlinux.org/$AUR_HELPER.git"
cd ~/$AUR_HELPER
makepkg -si --noconfirm
cd ~
rm -rf $AUR_HELPER

# # echo -ne "
# # -------------------------------------------------------------------------
# #                     Installing Graphics Drivers
# # -------------------------------------------------------------------------
# # "
# # Graphics Drivers find and install
# gpu_type=$(lspci)
# if grep -E "NVIDIA|GeForce" <<< ${gpu_type}; then
#     pacman -S --noconfirm --needed nvidia
# 	nvidia-xconfig
# elif lspci | grep 'VGA' | grep -E "Radeon|AMD"; then
#     pacman -S --noconfirm --needed xf86-video-amdgpu
# elif grep -E "Integrated Graphics Controller" <<< ${gpu_type}; then
#     pacman -S --noconfirm --needed libva-intel-driver libvdpau-va-gl lib32-vulkan-intel vulkan-intel libva-utils lib32-mesa
# elif grep -E "Intel Corporation UHD" <<< ${gpu_type}; then
#     pacman -S --needed --noconfirm libva-intel-driver libvdpau-va-gl lib32-vulkan-intel vulkan-intel libva-utils lib32-mesa
# fi
# echo -ne "
# -------------------------------------------------------------------------
#                     Installing CPU microcode  
# -------------------------------------------------------------------------
# "
# # determine processor type and install microcode
# proc_type=$(lscpu)
# if grep -E "GenuineIntel" <<< ${proc_type}; then
#     echo "Installing Intel microcode"
#     pacman -S --noconfirm --needed intel-ucode
#     proc_ucode=intel-ucode.img
# elif grep -E "AuthenticAMD" <<< ${proc_type}; then
#     echo "Installing AMD microcode"
#     pacman -S --noconfirm --needed amd-ucode
#     proc_ucode=amd-ucode.img
# fi



# BASE PACKAGES
# generate space-seperated string with package names:
BASE_PAC=`grep -vE "^\s*#|^\s*$" ~/LinuxConfig/installation-scripts/pkg/pac_base.txt | sed 's/#.*//' | tr '\n' ' '`
# install them:
sudo pacman -Syu $BASE_PAC --needed

# AUR
# generate space-seperated string with package names:
AUR_PAC=`grep -vE "^\s*#|^\s*$" ~/LinuxConfig/installation-scripts/pkg/aur-pkgs.txt | sed 's/#.*//' | tr '\n' ' '`
for package in $AUR_PAC; do
    echo "install $package"
    yay -S --needed $package
done

echo -ne "
-------------------------------------------------------------------------
                    Enabling Essential Services
-------------------------------------------------------------------------
"
systemctl enable cups.service
systemctl enable bluetooth
systemctl enable sshd
systemctl enable dhcpcd
systemctl enable NetworkManager
systemctl enable cronie.service
systemctl enable NetworkManager.service

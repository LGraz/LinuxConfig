
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

# FLATPAK
flatpak install flathub $(cat ~/LinuxConfig/installation-scripts/pkg/flatpak.txt)

echo -ne "
-------------------------------------------------------------------------
                    Enabling Essential Services
-------------------------------------------------------------------------
"
# EndeavourOS already enables NetworkManager, firewalld and fstrim
sudo systemctl enable cups.socket
sudo systemctl enable bluetooth
sudo systemctl enable sshd
sudo systemctl enable cronie
sudo systemctl enable tailscaled
sudo systemctl enable syncthing@$USER

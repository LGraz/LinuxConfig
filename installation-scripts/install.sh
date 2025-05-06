
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
sudo systemctl enable cups.socket
systemctl enable bluetooth
systemctl enable sshd
systemctl enable dhcpcd
systemctl enable NetworkManager
systemctl enable cronie.service
systemctl enable NetworkManager.service

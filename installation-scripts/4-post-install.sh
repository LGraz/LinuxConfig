# sudoers changes
    sudo sed -i -e '$aDefaults env_keep += PYTHONPATH' /etc/sudoers
    sudo sed -i -e '$aDefaults editor=/usr/bin/nano' /etc/sudoers


# remove bell-beeb
    echo 'blacklist pcspkr' | sudo tee -a /etc/modprobe.d/nobeeb.conf

# for ACER:
    # fix sound
    sudo rm /etc/modprobe.d/sound.conf
    echo "options snd-intel-dspcfg dsp_driver=1" | sudo tee -a /etc/modprobe.d/sound.conf > /dev/null
    echo "options snd-hda-intel model=dell-headset-multi" | sudo tee -a /etc/modprobe.d/sound.conf > /dev/null
    echo "options snd-hda-intel dmic_detect=0 " | sudo tee -a /etc/modprobe.d/sound.conf > /dev/null
    echo "options snd-hda-intel model=laptop-amic enable=yes" | sudo tee -a /etc/modprobe.d/sound.conf > /dev/null
    echo "options snd-hda-intel power_save=0" | sudo tee -a /etc/modprobe.d/sound.conf > /dev/null

### Improve laptop battery consumption
   sudo pacman -S tlp tlp-rdw 
#    sudo pacman -S powertop acpi
   sudo systemctl enable tlp
#    sudo systemctl enable tlp-sleep
   sudo systemctl mask systemd-rfkill.service
   sudo systemctl mask systemd-rfkill.socket
    # If your laptop is a ThinkPad, also run this:
    #    sudo pacman -S acpi_call

### Enable SSD TRIM
   sudo systemctl enable fstrim.timer

# fix touchpad
    sudo cp ~/ArchTitus/configs/etc/X11/xorg.conf.d/70-synaptics.conf /etc/X11/xorg.conf.d/70-synaptics.conf

# fix ETH-vpn issues  (disable ipv6)
    sudo cp ~/ArchTitus/configs/etc/sysctl.d/40-ipv6.conf /etc/sysctl.d/40-ipv6.conf

# # bluetooth
#     rfkill unblock all #unblock bluetooth is soft-blocked
#     bltid="38:18:4C:DA:A8:55" # WH-910N
#     bluetoothctl power on
#     bluetoothctl pair $bltid
#     bluetoothctl trust $bltid
#     # bluetoothctl connect $bltid
#     cp ~/ArchTitus/configs/config_files/bluetooth/.connect_wh910n ~/.connect_wh910n.sh
#     chmod +x .connect_wh910n.sh


# # for latex
#     sudo pacman -S cpanminus
#     sudo cpan Unicode::GCString
#     sudo cpan App::cpanminus
#     sudo cpan YAML::Tiny
#     sudo perl -MCPAN -e 'install "File::HomeDir"'

# keyboard layout
    localectl set-x11-keymap de acer_laptop nodeadkeys
    sudo localectl set-x11-keymap de acer_laptop nodeadkeys

# Acer - disable sleep
    sudo rm /etc/systemd/sleep.conf
    sudo ln -s ~/ArchTitus/configs/etc/systemd/sleep.conf /etc/systemd

# ZSH config
    sudo pacman -S zsh zsh-completions thefuck fzf
    chsh -s /bin/zsh
    # packages
        # autosuggestions
        git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
            # add to zshrc: "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"

        # powerlevel 10
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
            # echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
        
        # syntax highlighting
        sudo pacman -S zsh-syntax-highlighting
        # add to *end* of zshrc: "source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" 


# enable cronie
    sudo systemctl enable --now cronie.service

# LOCALE (english language & messages, swiss formats for everything else)
    sudo sed -i 's/^#en_DK.UTF-8 UTF-8/en_DK.UTF-8 UTF-8/' /etc/locale.gen
    sudo sed -i 's/^#de_CH.UTF-8 UTF-8/de_CH.UTF-8 UTF-8/' /etc/locale.gen
    sudo locale-gen
    sudo tee /etc/locale.conf <<EOF
LANG=en_DK.UTF-8
LC_ADDRESS=de_CH.UTF-8
LC_IDENTIFICATION=de_CH.UTF-8
LC_MEASUREMENT=de_CH.UTF-8
LC_MONETARY=de_CH.UTF-8
LC_NAME=de_CH.UTF-8
LC_NUMERIC=de_CH.UTF-8
LC_PAPER=de_CH.UTF-8
LC_TELEPHONE=de_CH.UTF-8
LC_TIME=en_DK.UTF-8
LC_MESSAGES=en_DK.UTF-8
EOF

# sudoers changes (own file instead of editing /etc/sudoers, then check syntax)
    printf 'Defaults env_keep += PYTHONPATH\nDefaults editor=/usr/bin/micro\n' | sudo tee /etc/sudoers.d/10-lukas
    sudo visudo -c

# remove bell-beep
    echo 'blacklist pcspkr' | sudo tee /etc/modprobe.d/nobeep.conf

# ZSH as login shell (prompt and plugins come from pacman, see pac_base.txt and .zshrc)
    chsh -s /bin/zsh

# PACKAGES (lists in pkg/, one package per line, everything after # is ignored)
    pkglist() { grep -vE '^\s*#|^\s*$' ~/LinuxConfig/installation-scripts/pkg/$1 | sed 's/#.*//' | tr '\n' ' '; }
    # pacman (official repos); also installs flatpak, which the next steps need
    sudo pacman -Syu --needed $(pkglist pac_base.txt)
    # AUR
    yay -S --needed $(pkglist aur-pkgs.txt)
    # Flathub
    flatpak install -y flathub $(pkglist flatpak.txt)

# SERVICES (EndeavourOS already enables NetworkManager, firewalld and fstrim)
    sudo systemctl enable cups.socket
    sudo systemctl enable bluetooth
    sudo systemctl enable sshd
    # sudo systemctl enable cronie
    sudo systemctl enable tailscaled
    sudo systemctl enable syncthing@$USER

# R: built from source into ~/.local/R/<version>, symlinked to ~/.local/bin (needs gcc-fortran etc. from pac_base.txt)
    R_VERSION=4.6.0   # latest on https://cran.r-project.org/src/base/R-4/
    bash ~/LinuxConfig/installation-scripts/R.sh $R_VERSION
    # R packages (R.sh already bootstrapped pak)
    ~/.local/R/$R_VERSION/bin/Rscript -e 'pak::pkg_install(unique(read.table("~/LinuxConfig/installation-scripts/pkg/r.txt", comment.char = "#")[[1]]), upgrade = FALSE)'

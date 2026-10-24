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

# ZSH as login shell (plugins are installed by zinit on first start, see .zshrc)
    chsh -s /bin/zsh

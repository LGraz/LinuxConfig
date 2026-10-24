# Fixes for the old Acer laptop only

# fix sound
    sudo rm /etc/modprobe.d/sound.conf
    echo "options snd-intel-dspcfg dsp_driver=1" | sudo tee -a /etc/modprobe.d/sound.conf > /dev/null
    echo "options snd-hda-intel model=dell-headset-multi" | sudo tee -a /etc/modprobe.d/sound.conf > /dev/null
    echo "options snd-hda-intel dmic_detect=0 " | sudo tee -a /etc/modprobe.d/sound.conf > /dev/null
    echo "options snd-hda-intel model=laptop-amic enable=yes" | sudo tee -a /etc/modprobe.d/sound.conf > /dev/null
    echo "options snd-hda-intel power_save=0" | sudo tee -a /etc/modprobe.d/sound.conf > /dev/null

# keyboard layout
    localectl set-x11-keymap ch acer_laptop
    sudo localectl set-x11-keymap ch acer_laptop

# disable sleep
    sudo mkdir -p /etc/systemd/sleep.conf.d
    printf '[Sleep]\nAllowSuspend=no\nAllowHibernation=no\nAllowSuspendThenHibernate=no\nAllowHybridSleep=no\n' | sudo tee /etc/systemd/sleep.conf.d/no-sleep.conf

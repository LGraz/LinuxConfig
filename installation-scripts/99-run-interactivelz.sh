# SSH keys: ~/.ssh is a symlink to ~/Work/.ssh (synced via Syncthing), .gitconfig comes from link_config.sh
    ln -s ~/Work/.ssh ~/.ssh
    ssh -T git@github.com # confirm with yes

# npm directory:
npm config set prefix ~/.local   # global tools land in ~/.local/bin (already on PATH)
npm install -g --allow-scripts=puppeteer md-to-pdf   # md-to-pdf/md2pdf; puppeteer downloads its Chromium

# Claude Code (official native installer, into ~/.local/bin)
curl -fsSL https://claude.ai/install.sh | bash

# tailscale (log in via browser)
    sudo tailscale up

# paperless (lives in ~/Documents/.paperless, see AGENTS.md)
    ~/Documents/.paperless/paperless.sh up

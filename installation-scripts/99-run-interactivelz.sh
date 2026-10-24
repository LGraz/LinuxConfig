# SSH keys: ~/.ssh is a symlink to ~/Work/.ssh (synced via Syncthing), .gitconfig comes from link_config.sh
    ln -s ~/Work/.ssh ~/.ssh
    ssh -T git@github.com # confirm with yes

# npm directory:
npm config set prefix ~/.npm-global

# tailscale (log in via browser)
    sudo tailscale up

# paperless (lives in ~/Documents/.paperless, see AGENTS.md)
    ~/Documents/.paperless/paperless.sh up

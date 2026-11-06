You find yourself on a ArchLinux system (installed via EndeavourOS) using KDE Plasma (Wayland).
Agents may edit this file to help future sessions, but keep it short and plain: I maintain it by hand.

Machines (check `hostname`; all reachable via tailscale, ssh with the shared key in ~/Work/.ssh):
- haken: my private laptop, ThinkPad X13 Gen 5 (EndeavourOS + KDE since 2026-11-05), details in `machines/haken.md`
- tukey: my work laptop, Fujitsu LIFEBOOK U9413, also EndeavourOS + KDE, details in `machines/tukey.md`
- dirichlet: my girlfriend's computer, ThinkPad X1 Yoga Gen 4 (the old salem hardware), Aurora (Fedora Atomic, not Arch), `ssh robin@dirichlet`, details in `machines/dirichlet.md`
- salem: my old private EndeavourOS install, now on the Acer Swift 3 SF315-52 (unstable, being retired; its home is copied to haken's ~/.salem), details in `machines/acer.md`

Syncthing setup:  
- ~/Work is synced between haken, tukey and salem
- ~/LinuxConfig is synced between haken, tukey and salem
- ~/Documents is synced between haken, tukey, salem, my phone
- ~/Pictures is synced between haken, tukey, salem, partially my phone (using a .stignore there)

Packages:  
- use flatpak for user apps or whenever advisable
- use pacman for systempackages

Backup:
- tukey: restic-sd-backup.timer backs up ~ to its built-in SD card (`bin/restic_sd_backup.sh`, excludes in `config_files/config_dirs/restic-tukey/`); this covers the synced folders above
- haken, salem: no backup yet (TODO)

Document management:
- paperless-ngx in rootless podman (podman-compose, no sudo), only started when needed, on one machine at a time (DB is synced via Syncthing)
- no login (auto-login as lukas), only reachable on http://127.0.0.1:8000
- `~/Documents/.paperless/`: compose.yaml (setup + paperless version pinned), paperless.sh (reference podman commands), SQLite DB, archive/thumbnails
- `~/Documents/Paperless/`: originals as CORRESPONDENT/DATE--TYPE--TITLE--TAGS, managed by paperless (browse only, never edit by hand)
- `~/Documents/Inbox/`: consume folder, imported on next start
- phones ignore `.paperless` via their .stignore
- docs: https://docs.paperless-ngx.com (upgrades: read release notes before bumping the pinned version)

You find yourself on a ArchLinux system (installed via EndeavourOS) using KDE.

Syncthing setup:  
- ~/Work is synced between this computer, my other computer
- ~/LinuxConfig is synced between this computer, my other computer
- ~/Documents is synced between this compuer, my other computer, my phone
- ~/Pictures is synced between this computer, my other computer, partially my phone (using a .stignore there)

Packages:  
- use flatpak for user apps or whenever advisable
- use pacman for systempackages

Backup:
- using restic on this and my other computer (TODO)

Docment management:
- paperless-ngx in rootless podman (podman-compose, no sudo), only started when needed, on one machine at a time (DB is synced via Syncthing)
- no login (auto-login as lukas), only reachable on http://127.0.0.1:8000
- `~/Documents/.paperless/`: compose.yaml (setup + paperless version pinned), paperless.sh (reference podman commands), SQLite DB, archive/thumbnails
- `~/Documents/Paperless/`: originals as CORRESPONDENT/DATE--TYPE--TITLE--TAGS, managed by paperless (browse only, never edit by hand)
- `~/Documents/Inbox/`: consume folder, imported on next start
- phones ignore `.paperless` via their .stignore
- docs: https://docs.paperless-ngx.com (upgrades: read release notes before bumping the pinned version)

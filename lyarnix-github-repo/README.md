# Lyarnix Build Kit (v0.1)

Familiar. Fast. Free.

This kit turns an Ubuntu Cinnamon ISO into a first Lyarnix ISO using Cubic.
It is a starting point and has NOT been test-built: expect to tweak.

## Steps
1. On an Ubuntu/Mint PC (or VM) install Cubic:
   sudo apt-add-repository ppa:cubic-wizard/release && sudo apt update && sudo apt install cubic
2. Download the Ubuntu Cinnamon LTS ISO from ubuntucinnamon.org (smaller + already Cinnamon).
3. Open Cubic, pick a project folder, choose that ISO, name the output "Lyarnix".
4. When Cubic opens its chroot terminal, use the copy button to put this whole
   folder in the chroot, then run:
       bash /root/lyarnix-build-kit/customize.sh
5. Click Next through Cubic's options (pick xz compression), then Generate.
6. Test the ISO in a VM (GNOME Boxes / virt-manager) before using real hardware.

## What's in here
- packages.txt          package list (edit freely)
- customize.sh          repos, installs, telemetry removal, overlay copy
- overlay/              files copied into the image:
  - usr/local/bin/lyvm              Windows 10/11 + custom ISO launcher (quickemu)
  - usr/local/bin/lyarnix-firstrun  installs Bottles, ProtonUp-Qt, Mission Center via Flatpak at first login
  - usr/share/themes/Lyarnix-*      Light/Dark GTK themes using your flag palette
  - etc/dconf/db/local.d/00-lyarnix Cinnamon defaults: bottom taskbar, start menu, tray, theme
  - etc/gamemode.ini                gaming performance defaults

## Palette
Dark Magenta #C479A2 | Pink #EEA6D2 | Lavender #D6C8E8 | White #FFFFFF | Light Blue #9AC8EB | Blue #6C83D1

## Known gaps / next work
- Cinnamon panel color (dark magenta taskbar) needs a custom Cinnamon shell theme (cinnamon.css).
- Notepad++ is Windows-only; Geany is included as the native stand-in (or run it in Bottles).
- Defender, Device Manager, Driver Manager GUI, Firmware panel, Recovery menu and instant search
  are not built yet. ClamAV, ubuntu-drivers, fwupd, Timeshift and plocate are installed as backends.
- Automatic Gaming Mode: gamemode is installed; set Steam launch option "gamemoderun %command%".
  A true auto-trigger for all games needs a small daemon (planned).
- Installer branding: add Calamares later (Cubic keeps Ubuntu's installer for now).
- Windows ISOs are downloaded from Microsoft by lyvm; a Windows license is still required.

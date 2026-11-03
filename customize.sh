#!/bin/bash
# Run INSIDE the Cubic chroot terminal:  bash /root/lyarnix-kit/customize.sh
# (Copy this whole folder into the chroot using Cubic's file-copy button first.)
set -euo pipefail
export DEBIAN_FRONTEND=noninteractive
KIT="$(cd "$(dirname "$0")" && pwd)"

echo "== Repos =="
apt-get update
apt-get install -y software-properties-common curl gpg
add-apt-repository -y universe
add-apt-repository -y multiverse
dpkg --add-architecture i386
add-apt-repository -y ppa:flexiondotorg/quickemu

# Firefox from Mozilla's APT repo (Ubuntu's Firefox is a snap, which does not install in a chroot)
install -d -m 0755 /etc/apt/keyrings
curl -fsSL https://packages.mozilla.org/apt/repo-signing-key.gpg -o /etc/apt/keyrings/packages.mozilla.org.asc
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" > /etc/apt/sources.list.d/mozilla.list
printf 'Package: *\nPin: origin packages.mozilla.org\nPin-Priority: 1000\n' > /etc/apt/preferences.d/mozilla

# Visual Studio Code
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /etc/apt/keyrings/microsoft.gpg
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list

apt-get update

echo "== Packages =="
apt-get install -y $(grep -vE '^\s*#|^\s*$' "$KIT/packages.txt") firefox code

echo "== Remove telemetry =="
apt-get purge -y ubuntu-report popularity-contest apport whoopsie kerneloops 2>/dev/null || true

echo "== Overlay (theme, launcher, defaults) =="
cp -a "$KIT/overlay/." /
chmod +x /usr/local/bin/lyvm /usr/local/bin/lyarnix-firstrun
dconf update

echo "== Flathub remote =="
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo || true

echo "== Branding =="
sed -i 's/^PRETTY_NAME=.*/PRETTY_NAME="Lyarnix"/; s/^NAME=.*/NAME="Lyarnix"/' /etc/os-release || true

echo "== Cleanup =="
apt-get autoremove -y
apt-get clean
echo "Done. Click Next in Cubic to continue building the ISO."

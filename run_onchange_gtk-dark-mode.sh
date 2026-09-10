#!/bin/sh
set -eu
# GTK's light/dark preference does not live in a config file.
#
# libadwaita apps -- loupe, snapshot, calculator, disks -- read
# org.gnome.desktop.interface color-scheme, which is stored in dconf's binary
# database. That file is deliberately gitignored, so the values have to be
# replayed by a script instead of tracked as content.
#
# The GTK3 half of the same problem is handled in gtk-3.0/settings.ini, which
# is a real file and is tracked normally.
#
# chezmoi re-runs this whenever the script's own contents change.

command -v gsettings >/dev/null 2>&1 || exit 0

gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Classic'
gsettings set org.gnome.desktop.interface cursor-size 24
gsettings set org.gnome.desktop.interface font-name 'Adwaita Sans 11'

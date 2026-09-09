# Tapo LED

The Waybar dot shows whether the light is connected and which color it is.

- Left-click switches between white and the warm preset: HSV (20, 80, 100).
- Middle-click selects the warm preset.
- Right-click turns the light on or off.
- Scroll changes brightness by 5%.
- Hover shows the current state and brightness.

The controller lives at https://github.com/BahadirAydin/waybar-tapo. Install or
update it with:

```sh
~/.config/waybar/modules/tapo-setup.sh
```

On a new machine, pass your old controller config the first time:

```sh
~/.config/waybar/modules/tapo-setup.sh /path/to/config.json
```

Credentials stay in `~/.config/waybar/tapo.json` and are not tracked by Git.
If the light gets a new address, update it with:

```sh
waybar-tapo --set-ip 192.168.1.10
```

If a Tapo effect is active, stop it in the Tapo app before changing color or
brightness from Waybar.

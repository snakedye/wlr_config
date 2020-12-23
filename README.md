![rice](screenshot.png)

#### usefull stuff

- waybar

- azote

- kdeconnect

- [wofer](https://gitlab.com/snakedye/wofer)

- brightnessctl

- grim

- slurp

- swappy

- swaylock-effects

- oguri (for dynamic wallpapers)

- nwg-launchers

- font awesome & nerd-fonts

#### install script

The script is written for pacman. If you use another package manager it will install config files but not packages.

1. `git clone https://github.com/snakedye/sway_config.git`

2. `cd sway_config`

3. `./install.sh` (use with the argument `y` for a quick install)

#### mangas

1. imv

2. fish

3. [mangadl-bash](https://github.com/Akianonymus/mangadl-bash)

4. fd (optionnal)

You need to set the `$HOME/.mangas` directory first otherwise the command will fail.

- `addmanga` adds mangas to the .mangas directory.
- `update_mangas` will update your library.
- `update_mangas argv[1] argv[2] ...` will update the titles passed.
- `manga_menu` displays the manga library using using nwggrid.

Wofer also has a manga extension.

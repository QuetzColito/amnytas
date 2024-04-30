{config, pkgs, ...}:

{
  imports = [
    ./hyprland/hyprland.nix
    ./tofi.nix
    ./waybar.nix
  ];

}


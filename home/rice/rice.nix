{config, pkgs, ...}:

{
  imports = [
    ./hyprland/hyprland.nix
    ./tofi.nix
    ./waybar.nix
    #./dunst.nix
    ./mako.nix
  ];


}


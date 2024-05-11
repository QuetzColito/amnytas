{config, pkgs, ...}:

{
  imports = [
    ./hyprland/hyprland.nix
    ./tofi.nix
    ./waybar.nix
  ];

  services.dunst = {
    enable = true;
    configFile = ./dunstrc;
    iconTheme = {
      name = "Tokyonight-Dark";
      package = pkgs.tokyo-night-gtk;
      size = "32x32";
    };
  };

}


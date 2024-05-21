{ config, pkgs, ... }:
let 
  wallpaper1 = "~/nixos/wallpaper/main.jpg";
in
{
  home.username = "arthezia";
  home.homeDirectory = "/home/arthezia";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  programs.alacritty.settings.shell.program = "/home/arthezia/.nix-profile/bin/zsh";

  imports = [
    ./home.nix
  ];

  services.hyprpaper.settings = {
    preload = [
      "${wallpaper1}"
    ];

    wallpaper = [
      ",${wallpaper1}"
    ];
  };

  programs.waybar.settings.mainbar.output = ["eDP-1"];
  programs.waybar.settings.mainbar.modules-left = ["battery"];

  wayland.windowManager.hyprland.settings = {
    workspace = [
      "1, monitor:eDP-1"
      "2, monitor:eDP-1"
      "3, monitor:eDP-1"
      "4, monitor:eDP-1"
      "5, monitor:eDP-1"
      "6, monitor:eDP-1"
      "7, monitor:eDP-1"
      "8, monitor:eDP-1"
      "9, monitor:eDP-1"
    ];
    monitor = [
      ",highrr,auto,1"
    ];
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

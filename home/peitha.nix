{ config, pkgs, ... }:
let 
  wallpaper1 = "~/nixos/wallpaper/vertical.jpg";
  wallpaper2 = "~/nixos/wallpaper/main.jpg";
  wallpaper3 = "~/nixos/wallpaper/side.jpg";
in 
{
  home.username = "quetz";
  home.homeDirectory = "/home/quetz";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  
  imports = [
    ./home.nix
  ]; 

  services.hyprpaper.settings = {
    preload = [
      "${wallpaper1}"
      "${wallpaper2}"
      "${wallpaper3}"
    ];

    wallpaper = [
      "DP-1,${wallpaper1}"
      "DP-2,${wallpaper2}"
      "HDMI-A-1,${wallpaper3}"
    ];
  };

  programs.waybar.settings.mainbar.output = ["HDMI-A-1" "DP-1" "DP-2"];

  wayland.windowManager.hyprland = {
    settings = {
      exec-once = [
        "firefox"
        "for i in ~/apps/ytm/*.AppImage ; do appimage-run $i; done" # EXTERNAL DEPENDENCY
        "flatpak run dev.vencord.Vesktop" # EXTERNAL DEPENDENCY
	      "sleep 5; hyprctl dispatch resizewindowpixel exact 100% 30%,YouTube"
      ];
    };
  };

  wayland.windowManager.hyprland.settings = {
    workspace = [
      "1, monitor:DP-1"
      "2, monitor:DP-1"
      "3, monitor:DP-1"
      "4, monitor:DP-2"
      "5, monitor:DP-2"
      "6, monitor:DP-2"
      "7, monitor:HDMI-A-1"
      "8, monitor:HDMI-A-1"
      "9, monitor:HDMI-A-1"
    ];
    monitor = [
      ",highrr,auto,1"
      "DP-2,preferred,0x0,1"
      "HDMI-A-1,preferred,2560x360,1"
      "DP-1,preferred,-1080x-300,1,transform,1"
    ];
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

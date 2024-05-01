{ config, pkgs, ... }:

{
  home.username = "quetz";
  home.homeDirectory = "/home/quetz";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  imports = [
    ./home.nix
  ]; 

    home.file.".config/hypr/hyprpaper.conf".text = ''
    $WP1 = ~/Media/Wallpaper/vanitas_sis.jpg
    $WP2 = ~/Media/Wallpaper/ruanmei.jpg
    $WP3 = ~/Media/Wallpaper/frieren-bonfire.jpg

    preload = $WP1
    preload = $WP2
    preload = $WP3

    wallpaper = DP-1,$WP1
    wallpaper = DP-2,$WP2
    wallpaper = HDMI-A-1,$WP3

    splash = false

    ipc = off
  '';

  programs.waybar.settings.mainbar.output = ["HDMI-A-1" "DP-1" "DP-2"];

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
      "HDMI-A-1,1920x1080@60,2560x360,1"
      "DP-1,1920x1080@74,-1080x-300,1,transform,1"
      "DP-2,2560x1440@164.95799,0x0,1"
    ];
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

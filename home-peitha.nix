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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

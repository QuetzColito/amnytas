{ config, pkgs, ... }:

{
  home.username = "arthezia";
  home.homeDirectory = "/home/arthezia";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  imports = [
    ./home.nix
  ];
  home.file.".config/hypr/hyprpaper.conf".text = ''
    $WP1 = ~/Media/Wallpaper/ruanmei.jpg

    preload = $WP1

    wallpaper = ,$WP1

    splash = false

    ipc = off
  '';

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

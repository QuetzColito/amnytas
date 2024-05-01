{ config, pkgs, ... }:

{
  home.username = "arthezia";
  home.homeDirectory = "/home/arthezia";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  imports = [
    ./home.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

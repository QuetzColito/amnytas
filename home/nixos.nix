{
  lib,
  pkgs,
  ...
}: {
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./dev/nixvim/nixvim.nix
    ../stylix.nix
    ./programs/zsh.nix
  ];

  home.shellAliases = {
    hs = "home-manager switch --flake ~/nixos";
    hn = "home-manager news --flake ~/nixos";
    ns = "sudo nixos-rebuild switch --flake ~/nixos";
  };

  programs.git = {
    enable = true;
    userEmail = "stefan.lahne@teleport.de";
    userName = "Stefan Lahne";
  };

  programs.zellij = {
    enable = true;
  };

  home.packages = with pkgs; [

    # General
    starship
    nil
    cmatrix
    sl
    fastfetch
    pandoc
    texliveSmall
    gnumake

    # Utils
    zip
    unzip
    lazygit
    usbutils
    poppler_utils
    ffmpeg

    # Files
    fzf
    fd

  ];
}

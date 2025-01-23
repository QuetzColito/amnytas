{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./zsh.nix
    ./yazi.nix
    ./nixvim
    ./git.nix
    # ./nushell.nix
  ];

  programs = {
    oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      settings = import ./ohmyposh.nix;
    };

    zellij = {
      enable = true;
    };
  };

  # better cat
  programs.bat = {
    enable = true;
    config = {
      paging = "never";
    };
  };

  # better ls? not sure if ill use this yet
  programs.eza.enable = true;

  home.packages = with pkgs;
    [
      docker
      micro
      jq
      calc
      pandoc
      texliveSmall
      mpg123
      zip
      unar
      imagemagick
      ffmpeg
      fd
      tealdeer
      gnumake
    ]
    ++ config.tuiPackages;
  tuiPackages = with pkgs; [
    yazi
    btop
    cmatrix
    lazydocker
    sl
    fastfetch
    fzf
    zellij
  ];
}

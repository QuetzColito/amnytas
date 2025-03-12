{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./zsh.nix
    ./yazi.nix
    # ./nixvim
    ./nvf
    ./git.nix
  ];

  programs = {
    oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      settings = import ./ohmyposh.nix;
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
      silent = true;
    };

    # better cat
    bat = {
      enable = true;
      config = {
        paging = "never";
      };
    };

    eza.enable = true;
  };

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
      (writeShellScriptBin
        "lang"
        ''nix flake init --template "https://flakehub.com/f/the-nix-way/dev-templates/*#$@"'')
      (writeShellScriptBin "try" "nix run nixpkgs#$@")
    ]
    ++ config.tuiPackages;
  tuiPackages = with pkgs; [
    yazi
    btop
    nvtopPackages.full
    cmatrix
    lazydocker
    sl
    fastfetch
    fzf
    zellij
  ];
}

{
  pkgs,
  self,
  inputs,
  config,
  ...
}: let
  tuiPackages = with pkgs; [
  ];
in {
  imports = [
    ./zsh.nix
    ./yazi
    ./console.nix
  ];

  files.".config/oh-my-posh/config.toml".source = ./oh-my-posh.toml;
  system.activationScripts.clearohmyposhcache.text = "rm -rf /home/${config.mainUser}/.cache/oh-my-posh";

  packages = with pkgs; [
    btop
    cmatrix
    lazydocker
    sl
    fastfetch
    fzf
    self.packages.${pkgs.stdenv.system}.nvf
    docker
    micro
    jq
    calc
    go
    pandoc
    texliveSmall
    typst
    oh-my-posh
    inputs.putah.packages.${pkgs.stdenv.system}.putah
    mpg123
    zip
    unzip
    unar
    imagemagick
    ffmpeg
    fd
    lazygit
    tealdeer
    (writeShellScriptBin
      "restart-gozy"
      ''ssh quetz@quetz.dev -f "pkill -f gozy"; ssh quetz@quetz.dev "nohup nix run 'github:QuetzColito/gozy' > gozy.log 2>&1 &"'')
    (writeShellScriptBin
      "lang"
      ''nix flake init --template "https://flakehub.com/f/the-nix-way/dev-templates/*#$@"'')
    (writeShellScriptBin "try" "nix run nixpkgs#$@")
    (writeShellScriptBin "bios" "systemctl reboot --firmware-setup")
  ];
}

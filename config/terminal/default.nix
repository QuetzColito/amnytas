{
  pkgs,
  self,
  inputs,
  ...
}: let
  tuiPackages = with pkgs; [
    yazi
    btop
    nvtopPackages.full
    cmatrix
    lazydocker
    sl
    fastfetch
    fzf
  ];
in {
  imports = [
    ./zsh.nix
    ./yazi
    ./console.nix
  ];

  files.".config/oh-my-posh/config.toml".source = ./oh-my-posh.toml;

  packages = with pkgs;
    [
      self.packages.${pkgs.stdenv.system}.nvf
      docker
      micro
      jq
      comma
      calc
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
      gnumake
      (writeShellScriptBin
        "lang"
        ''nix flake init --template "https://flakehub.com/f/the-nix-way/dev-templates/*#$@"'')
      (writeShellScriptBin "try" "nix run nixpkgs#$@")
      (writeShellScriptBin "bios" "systemctl reboot --firmware-setup")
      (writers.writeRustBin "filter-tofi" {} ''
        use std::env;
        fn main() {
            let arg = &env::args().last().unwrap();
            let tuis = vec![${builtins.concatStringsSep "," (map (p: "\"" + (builtins.toString (lib.meta.getExe p)) + "\"") tuiPackages)}];
            println!(
                "{}{}",
                if tuis.into_iter().any(|tui| tui.ends_with(arg)) {
                    "foot "
                } else {
                    ""
                },
                arg
            );
        }
      '')
    ]
    ++ tuiPackages;
}

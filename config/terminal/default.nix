{
  pkgs,
  self,
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
    ./oh-my-posh.nix
    ./zsh.nix
    ./yazi.nix
    ./console.nix
  ];

  packages = with pkgs;
    [
      self.packages.${pkgs.stdenv.system}.nvf
      docker
      micro
      jq
      calc
      pandoc
      texliveSmall
      typst
      oh-my-posh
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

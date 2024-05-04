{config, pkgs, ...}:
{
  imports = [
    ./nvim.nix
  ];
  home.packages = with pkgs; [
    haskell.compiler.ghc94
    cabal-install
    hlint
    jdt-language-server
    eclipses.eclipse-platform
    #haskellPackages.hls
    #haskellPackages.ghcup
    R
    rPackages.languageserver
    rstudioWrapper
    corepack
    docker
    lazydocker
  ];



}


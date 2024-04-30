{config, pkgs, ...}:
{
  home.packages = with pkgs; [
    jdk
    haskell.compiler.ghc94
    cabal-install
    hlint
    #haskellPackages.hls
    #haskellPackages.ghcup
    R
    rPackages.languageserver
    rstudioWrapper
    corepack
  ];



}


{config, pkgs, ...}:
{
  imports = [
    
  ];
  home.packages = with pkgs; [
    haskell.compiler.ghc94
    cabal-install
    hlint
    jdt-language-server
    eclipses.eclipse-platform
    rust-analyzer
    cargo
    rustc
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


{config, pkgs, ...}:
{
  imports = [
    
  ];

  home.packages = with pkgs; [
    haskell.compiler.ghc94
    cabal-install
    hlint
    jdk
    jdt-language-server
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
  home.sessionVariables = {
    JAVA_HOME = "${pkgs.jdk}";
    TEST = "testing";
  };
}


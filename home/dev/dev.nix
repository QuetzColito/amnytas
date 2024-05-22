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
    (eclipses.eclipseWithPlugins {
      eclipse = eclipses.eclipse-java;
      jvmArgs = [ "-Xmx2048m" ];
      plugins = [ 
        eclipses.plugins.color-theme 
        eclipses.plugins.vrapper  
      ];
    })
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
  };
}


{
  pkgs,
  ...
} : {
    imports = [
        ./nixvim
    ];

    home.packages = with pkgs; [
        haskell.compiler.ghc94
        cabal-install
        hlint
        jdk17
        jdt-language-server
        rust-analyzer
        cargo
        rustc
        corepack
        docker
        maven
        lazydocker
    ];
    home.sessionVariables = {
        JAVA_HOME = "${pkgs.jdk17}";
    };
}

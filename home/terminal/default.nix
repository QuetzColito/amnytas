{
  pkgs,
  ...
} : {
    imports = [
        ./zsh.nix
        ./yazi.nix
        ./nixvim
    ];


    programs = {

        git = {
            enable = true;
            extraConfig.init.defaultBranch = "main";
        };

        oh-my-posh = {
            enable = true;
            enableZshIntegration = true;
            settings = import ./ohmyposh.nix;
        };

        zellij = {
            enable = true;
        };
    };

    home.packages = with pkgs; [
        starship
        btop
        cmatrix
        docker
        lazydocker
        micro
        sl
        jq
        calc
        python3
        fastfetch
        pandoc
        mpg123
        texliveSmall
        gnumake
        zip
        unar
        imagemagick
        lazygit
        ffmpeg
        fzf
        fd
    ];
}

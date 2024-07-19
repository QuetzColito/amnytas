{
  pkgs,
  ...
} : {
    imports = [
        ./zsh.nix
        ./yazi.nix
    ];


    programs = {

        git = {
            enable = true;
            userEmail = "stefan.lahne@gmx.de";
            userName = "Stefan Lahne";
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
        sl
        fastfetch
        pandoc
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

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
        imagemagick
        unzip
        lazygit
        ffmpeg
        fzf
        fd
    ];
}

{
  pkgs,
  config,
  lib,
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
            extraConfig = {
                init.defaultBranch = "main";
                include.path = "~/amnytas/home/terminal/themes.gitconfig";
            };
            delta = {
                enable = true;
                options = {
                    features = "villsau";
                    syntax-theme = "base16-stylix";
                    line-numbers = true;
                };
            };
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

    programs.lazygit = {
        enable = true;
        settings = {
            gui.theme = lib.mkForce {
                activeBorderColor = [ "magenta" "bold" ];
                inactiveBorderColor = [ "cyan" ];
                searchingActiveBorderColor = [ "cyan" "bold" ];
                optionsTextColor = [ "cyan" "bold" ];
                selectedLineBgColor = [ "default" ];
                inactiveViewSelectedBorderColor = [ "bold" ];
                cherryPickedCommitFgColor = [ "blue" ];
                cherryPickedCommitBgColor = [ "cyan" ];
                markedBaseCommitFgColor = [ "blue" ];
                markedBaseCommitBgColor = [ "yellow" ];
                unstagedChangesColor = [ "red" ];
                defaultFgColor = [ "default" ];
            };
            git.paging = {
                colorArg = "always";
                pager = "delta --paging=never";
            };

        };
    };

    programs.bat = {
        enable = true;
        config = {
            paging = "never";
        };
    };

    programs.eza.enable = true;

    home.packages = with pkgs; [
        btop
        cmatrix
        docker
        lazydocker
        micro
        sl
        jq
        calc
        fastfetch
        pandoc
        mpg123
        texliveSmall
        gnumake
        zip
        unar
        imagemagick
        ffmpeg
        fzf
        fd
        tldr
    ];
}

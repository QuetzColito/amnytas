{
  pkgs,
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
                # TODO: use fetchFromGitHub
                include.path = "~/amnytas/home/terminal/themes.gitconfig";
            };
            # prettier lazygit, not 100% happy with this tho
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
            # for some reason, without mkForce the colors all get weird
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

    # better cat
    programs.bat = {
        enable = true;
        config = {
            paging = "never";
        };
    };

    # better ls? not sure if ill use this yet
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

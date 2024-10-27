{lib, ...}: {
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

    lazygit = {
      enable = true;

      settings = {
        # for some reason, without mkForce the colors all get weird
        gui.theme = lib.mkForce {
          activeBorderColor = ["magenta" "bold"];
          inactiveBorderColor = ["cyan"];
          searchingActiveBorderColor = ["cyan" "bold"];
          optionsTextColor = ["cyan" "bold"];
          selectedLineBgColor = ["default"];
          inactiveViewSelectedBorderColor = ["bold"];
          cherryPickedCommitFgColor = ["blue"];
          cherryPickedCommitBgColor = ["cyan"];
          markedBaseCommitFgColor = ["blue"];
          markedBaseCommitBgColor = ["yellow"];
          unstagedChangesColor = ["red"];
          defaultFgColor = ["default"];
        };

        git.paging = {
          colorArg = "always";
          pager = "delta --paging=never";
        };
      };
    };
  };
}

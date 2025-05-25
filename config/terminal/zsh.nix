{pkgs, ...}: {
  programs.direnv = {
    enable = true;
    silent = true;
    enableZshIntegration = true;
  };

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    SHELL = "zsh";
  };

  environment.shellAliases = {
    e = "hyprctl dispatch exec --";
    lz = "lazygit";
    v = "nvim";
    ns = "nh os switch";
    nb = "nh os boot";
    nu = "nix flake update --flake ~/amnytas --commit-lock-file";
    "nix-shell" = "nix-shell --command zsh";
    nd = "nix develop -c zsh";
  };

  files.".zshrc".text = ''
    # Dont leave this empty
    printf '\033[?12l' # This disables cursor blinking
  '';

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    promptInit = ''eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/config.toml)" '';

    histSize = 10000;

    ohMyZsh = {
      enable = true;
      plugins = ["vi-mode"];
      customPkgs = with pkgs; [
        zsh-vi-mode
      ];
    };
  };
}

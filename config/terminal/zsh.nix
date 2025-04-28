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
    nu = "nix flake update --flake ~/amnytas --commit-lock-file";
    "nix-shell" = "nix-shell --command zsh";
    nd = "nix develop -c zsh";
  };

  files.".zshrc".text = ''
    # Dont leave this file empty unless you want new user experience :D
    printf '\033[?12l' # This disables cursor blinking
  '';

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    histSize = 10000;
    promptInit = ''eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/config.toml)"'';

    ohMyZsh = {
      enable = true;
      plugins = ["vi-mode"];
      customPkgs = with pkgs; [
        zsh-vi-mode
      ];
    };
  };
}

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
    ns = "sudo nixos-rebuild switch --flake ~/amnytas";
    nu = "nix flake update --flake ~/amnytas --commit-lock-file";
    start = "uwsm app --";
  };

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
      customPkgs = [pkgs.zsh-vi-mode];
    };
  };
}

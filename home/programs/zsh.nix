{...}:

{
  home.sessionVariables.SHELL = "zsh";

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    autocd = true;
    history = {
      size = 10000;
    };
    syntaxHighlighting.enable = true;

    initExtra = "eval \"$(starship init zsh)\" ";

  };
}

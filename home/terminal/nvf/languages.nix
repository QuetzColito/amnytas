_: {
  programs.nvf.settings.vim = {
    languages = {
      # global opts
      enableExtraDiagnostics = true;
      enableFormat = true;
      enableLSP = true;
      enableTreesitter = true;

      # Languages
      nix.enable = true;
    };
  };
}

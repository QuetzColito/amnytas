{pkgs, ...}: {
  config.vim = {
    languages = {
      # global opts
      enableExtraDiagnostics = true;
      enableFormat = true;
      enableTreesitter = true;

      # Languages
      nix.enable = true;
      rust.enable = true;
      ts.enable = false;
      python.enable = true;
      java.enable = true;
      typst = {
        enable = true;
        format.enable = false;
      };
    };

    lsp.lspconfig.sources.qmlls = ''
      lspconfig.qmlls.setup {
        cmd = {"${pkgs.kdePackages.qtdeclarative}/bin/qmlls", "-E"}
      }
    '';
  };
}

{...} :
{
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;

        keymaps = {
          silent = true;
          diagnostic = {
            "<leader>k" = "goto_prev";
            "<leader>j" = "goto_next";
          };

          lspBuf = {
            gd = "definition";
            gD = "references";
            gt = "type_definition";
            gi = "implementation";
            K = "hover";
            "<F2>" = "rename";
          };
        };

        servers = {
          nixd.enable = true;
          hls.enable = true;
          java-language-server = {
            enable = true;
            rootDir = "function() return '/home/quetz/dev/seq/suffix/' end";
          };
        };
      };
    };
  };
}

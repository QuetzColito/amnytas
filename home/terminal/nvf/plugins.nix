{
  pkgs,
  lib,
  ...
}: {
  programs.nvf.settings.vim = {
    treesitter.enable = true;
    lsp = {
      enable = true;
      lspkind.enable = true;
      formatOnSave = true;
    };
    extraPlugins = with pkgs.vimPlugins; {
      oil = {
        package = oil-nvim;
        setup = ''
          require('oil').setup()
        '';
      };
    };
    mini = {
      icons.enable = true;
      operators.enable = true;
    };
    terminal.toggleterm = {
      enable = true;
      mappings.open = "<C-l>";
      setupOpts = {
        direction = "float";
        winbar.enable = false;
      };
      lazygit = {
        enable = true;
        mappings.open = "<C-g>";
      };
    };
    statusline.lualine.enable = true;
    autocomplete.nvim-cmp.enable = true;
    telescope = lib.mkForce {
      enable = true;
      mappings = {
        liveGrep = "<C-f>";
        findFiles = "<leader>f";
        open = "<leader>t";
      };
    };
    autopairs.nvim-autopairs.enable = true;
  };
}

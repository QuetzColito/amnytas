_: {
  programs.nvf.settings.vim = {
    treesitter.enable = true;
    lsp = {
      enable = true;
      lspkind.enable = true;
      formatOnSave = true;
    };
    mini = {
      icons.enable = true;
      operators.enable = true;
      files = {
        enable = true;
        setupOpts = {
          windows.max_number = 1;
          mappings = {
            go_in = " ";
            go_in_plus = "l";
            go_out_plus = "h";
          };
        };
      };
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
    telescope = {
      enable = true;
      mappings = {
        liveGrep = "<C-f>";
        findFiles = "<leader>ff";
        open = "<leader>t";
      };
    };
    autopairs.nvim-autopairs.enable = true;
  };
}

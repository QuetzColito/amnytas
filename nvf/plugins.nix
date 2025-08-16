_: {
  config.vim = {
    treesitter.enable = true;
    statusline.lualine.enable = true;
    autocomplete.blink-cmp.enable = true;
    autopairs.nvim-autopairs.enable = true;
    visuals.rainbow-delimiters.enable = true;
    ui.colorizer.enable = true;
    git.gitsigns.enable = true;
    binds.whichKey.enable = true;

    lsp = {
      enable = true;
      lspkind.enable = true;
      formatOnSave = true;
      mappings = {
        goToDefinition = "gd";
      };
    };

    mini = {
      icons.enable = true;
      operators.enable = true;
      comment = {
        enable = true;
        setupOpts = {
          options.ignore_blank_line = true;
          mappings = {
            comment_line = "<C-/>";
            comment_visual = "<C-/>";
          };
        };
      };
    };

    terminal.toggleterm = {
      enable = true;
      mappings.open = "<C-l>";
      setupOpts = {
        direction = "float";
        shell = "zsh";
        winbar.enable = false;
      };
      lazygit = {
        enable = true;
        mappings.open = "<C-g>";
      };
    };

    fzf-lua = {
      enable = true;
      setupOpts = {
        winopts.backdrop = 100;
        fzf_colors = true;
      };
    };
  };
}

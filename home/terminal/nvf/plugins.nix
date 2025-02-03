{
  lib,
  config,
  ...
}: {
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
        shell = config.home.sessionVariables.SHELL;
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
    visuals.rainbow-delimiters.enable = true;
  };
}

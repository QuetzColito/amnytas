{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./telescope.nix
    ./lsp.nix
    ./treesitter.nix
    ./cmp.nix
    ./neotree.nix
    ./markdown.nix
    ./lazygit.nix
    ./mini.nix
    ./tex.nix
  ];

  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    vim-closetag
    yuck-vim
  ];

  programs.nixvim.plugins = {
    transparent.enable = true;
    luasnip.enable = true;
    web-devicons.enable = true;
    rainbow-delimiters.enable = true;
    # hardtime.enable = true;

    gitsigns = {
      enable = true;
      settings.signs = {
        add.text = "+";
        change.text = "~";
      };
    };

    colorizer = {
      enable = true;
      settings.user_default_options.names = false;
    };

    oil.enable = true;

    trim = {
      enable = true;
      settings = {
        highlight = true;
        ft_blocklist = [
          "checkhealth"
          "floaterm"
          "lspinfo"
          "neo-tree"
          "TelescopePrompt"
        ];
      };
    };

    comment = {
      enable = true;
      settings = {
        opleader.line = "<C-/>";
        toggler.line = "<C-/>";
      };
    };

    lualine.enable = true;

    floaterm = {
      enable = true;
      settings = {
        shell = config.home.sessionVariables.SHELL;
        keymap_toggle = "<C-L>";
        keymap_next = "<C-J>";
        keymap_prev = "<C-K>";
        keymap_new = "<C-H>";
        width = 0.8;
        height = 0.8;
        title = "";
      };
    };
  };
}

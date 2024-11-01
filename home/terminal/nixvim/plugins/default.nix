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

    nvim-colorizer = {
      enable = true;
      userDefaultOptions.names = false;
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
      shell = config.home.sessionVariables.SHELL;
      keymaps = {
        toggle = "<C-L>";
        next = "<C-J>";
        prev = "<C-K>";
        new = "<C-H>";
      };
      width = 0.8;
      height = 0.8;
      title = "";
    };
  };
}

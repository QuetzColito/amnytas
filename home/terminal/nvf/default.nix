{inputs, ...}: {
  imports = [
    inputs.nvf.homeManagerModules.default
    ./keymap.nix
    ./options.nix
    ./plugins.nix
    ./extra-plugins.nix
    ./languages.nix
  ];
  programs.nvf = {
    enable = true;

    # Theme
    settings.vim = {
      theme = {
        enable = true;
        name = "tokyonight";
        style = "night";
        transparent = true;
      };
      # Extra Transparency
      luaConfigPost = ''
        vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = "#9d7cd8", bg = "none"})
        vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = "#bb9af7", bg = "none"})
        vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = "#ff9e64", bg = "none"})
        vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#ff9e64", bg = "none"})
        vim.api.nvim_set_hl(0, "MiniFilesTitleFocused", { fg = "#ff9e64", bg = "none"})
        vim.api.nvim_set_hl(0, "TelescopeNormal", { fg = "#a9b1d6", bg = "none"})
        vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#bb9af7", bg = "none"})
        vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#9d7cd8", bg = "none"})
        vim.api.nvim_set_hl(0, "FloatTitle", { fg = "#9d7cd8", bg = "none"})
        vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#9d7cd8", bg = "none"})
        vim.api.nvim_set_hl(0, "FloatermBorder", { fg = "#9d7cd8", bg = "none"})
      '';
    };
  };
}

{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nvf.homeManagerModules.default
    ./keymap.nix
    ./options.nix
    ./plugins.nix
    ./extra-plugins.nix
    ./languages.nix
  ];

  home.shellAliases.v = "nvim";

  home.packages = with pkgs; [
    zathura
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

        vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = "*.tex",
            callback = function()
              vim.cmd("silent !lualatex % > /dev/null 2>&1 &")
            end,
        })

        vim.api.nvim_create_autocmd("BufReadPost", {
            pattern = "*.tex",
            callback = function()
                local pdf_file = vim.fn.expand("%:r") .. ".pdf"
                vim.cmd("silent !uwsm app zathura " .. pdf_file .. " > /dev/null 2>&1 &")
            end,
        })

        vim.api.nvim_create_autocmd("BufReadPost", {
            pattern = "*.typ",
            callback = function()
                local pdf_file = vim.fn.expand("%:r") .. ".pdf"
                local typ_file = vim.fn.expand("%:r") .. ".typ"
                vim.cmd("silent !uwsm app zathura " .. pdf_file .. " > /dev/null 2>&1 &")
                vim.cmd("silent !typst watch " .. typ_file .. " > /dev/null 2>&1 &")
            end,
        })

        vim.api.nvim_create_autocmd("VimLeavePre", {
            pattern = "*.typ",
            callback = function()
                vim.cmd("silent !pkill zathura > /dev/null 2>&1 &")
            end,
        })

        vim.api.nvim_create_autocmd("VimLeavePre", {
            pattern = "*.tex",
            callback = function()
                vim.cmd("silent !pkill zathura > /dev/null 2>&1 &")
            end,
        })
      '';
    };
  };
}

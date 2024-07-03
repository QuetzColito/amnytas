{ ... } :
{
  programs.nixvim.opts = {
    number = true;
    scrolloff = 10;
    relativenumber = true;
    breakindent = true;
    copyindent = true;

    shiftwidth = 2;
    tabstop = 2;
    softtabstop=2;
    expandtab = true;
    # wrap = false;

    list = true;
    listchars = "tab:» ,trail:·,nbsp:␣";
    fillchars = "eob:";
    cursorline = true;
    undofile = true;
    hlsearch = true;
  };

  # programs.nixvim.extraConfigLua = ''
  #   vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
  #   vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })
  #   vim.g.tokyonight_dark_float = false
  # '';
}

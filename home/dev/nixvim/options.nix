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
    cursorline = true;
    undofile = true;
    hlsearch = true;
  };
}

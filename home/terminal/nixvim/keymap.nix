{
  config,
  lib,
  ...
} : {
    programs.nixvim = {
        globals = {
        mapleader = " ";
        maplocalleader = " ";
    };

    keymaps = let
        normal =
        lib.mapAttrsToList
        (key: action: {
            mode = "n";
            inherit action key;
        })
        {
            "<Space>" = "<NOP>";

            # Esc to clear search results
            "<esc>" = ":noh<CR>";

            # fix Y behaviour
            # Y = "y$";

            # back and fourth between the two most recent files
            "ga" = ":b#<CR>";

            # open File Explorer
            "-" = "<CMD>Oil<CR>";

            # close by Ctrl+x
            "<C-x>" = ":close<CR>";

            # "gc" = "Vgc";

            # save by Space+s or Ctrl+s
            "<leader>s" = ":w<CR>";
            "<C-s>" = ":w<CR>";

            # navigate to left/right window
            "<leader>h" = "<C-w>h";
            "<leader>l" = "<C-w>l";

            # Press 'H', 'L' to jump to start/end of a line (first/last character)
            L = "$";
            H = "^";

            # resize with arrows
            "<C-Up>" = ":resize -2<CR>";
            "<C-Down>" = ":resize +2<CR>";
            "<C-Left>" = ":vertical resize +2<CR>";
            "<C-Right>" = ":vertical resize -2<CR>";

        };
        visual =
        lib.mapAttrsToList
        (key: action: {
            mode = "v";
            inherit action key;
        })
        {
            # better indenting
            ">" = ">gv";
            "<" = "<gv";
            "<TAB>" = ">gv";
            "<S-TAB>" = "<gv";

            # move selected line / block of text in visual mode
            "K" = ":m '<-2<CR>gv=gv";
        "J" = ":m '>+1<CR>gv=gv";
        };
    in
    config.lib.nixvim.keymaps.mkKeymaps
    {options.silent = true;}
    (normal ++ visual);
    };
}

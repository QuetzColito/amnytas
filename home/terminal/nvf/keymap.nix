{lib, ...}: {
  programs.nvf.settings.vim.keymaps = let
    normal =
      lib.mapAttrsToList (key: action: {
        mode = "n";
        silent = true;
        inherit key action;
      })
      {
        "<esc>" = "<cmd>noh<CR>";
        "ga" = "<cmd>b#<CR>";
        "-" = "<cmd>lua MiniFiles.open()<CR>";

        # One-handed Write/Quit
        "<leader>w" = ":w<CR>";
        "<leader>q" = ":q<CR>";

        # navigate to left/right window
        "<leader>h" = "<C-w>h";
        "<leader>l" = "<C-w>l";

        # resize with arrows
        "<C-Up>" = ":resize -2<CR>";
        "<C-Down>" = ":resize +2<CR>";
        "<C-Left>" = ":vertical resize +2<CR>";
        "<C-Right>" = ":vertical resize -2<CR>";
      };
    visual =
      lib.mapAttrsToList (key: action: {
        mode = "v";
        silent = true;
        inherit key action;
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
    normal
    ++ visual
    ++ [
      {
        mode = "t";
        key = "<C-L>";
        action = "<cmd>ToggleTermToggleAll<CR>";
      }
    ];
}

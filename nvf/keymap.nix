{lib, ...}: {
  config.vim.keymaps = let
    normal =
      lib.mapAttrsToList (key: action: {
        mode = "n";
        silent = true;
        inherit key action;
      })
      {
        # Remove search highlight with escape
        "<esc>" = "<cmd>noh<CR>";
        # Alternate File
        "ga" = "<cmd>b#<CR>";
        # Files
        "-" = "<cmd>Oil<CR>";

        # FzfLua
        "<leader>f" = ":FzfLua files<CR>";
        "<leader>t" = ":FzfLua builtin<CR>";
        "<C-F>" = ":FzfLua grep<CR>";

        # Copy/Paste to System
        "<leader>y" = "\"+y";
        "<leader>p" = "\"+p";

        # One-handed Write/Quit
        "<leader>w" = ":w<CR>";
        "<leader>q" = ":q<CR>";
        "<leader>d" = "<cmd>lua vim.diagnostic.open_float()<CR>";

        # Format
        "Q" = "gq";
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

        "<leader>y" = "\"+y";
        "<leader>p" = "\"+p";

        # move selected line / block of text in visual mode
        "K" = ":m '<-2<CR>gv=gv";
        "J" = ":m '>+1<CR>gv=gv";

        # Format
        "Q" = "gq";
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

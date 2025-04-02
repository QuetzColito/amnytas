{lib, ...}: let
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

      # One-handed Write/Quit
      "<leader>w" = ":w<CR>";
      "<leader>q" = ":q<CR>";
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
  ]

{ ... } :
{
  programs.nixvim = {
    keymaps = [
      {
        mode = "n";
        key = "<leader>g";
        action = ":LazyGit<CR>";
      }
    ];

    plugins.lazygit.enable = true;
  };
}

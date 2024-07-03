{ ... } :
{
  programs.nixvim = {
    keymaps = [
      {
        mode = "n";
        key = "<C-g>";
        action = ":LazyGit<CR>";
      }
    ];

    plugins.lazygit.enable = true;
  };
}

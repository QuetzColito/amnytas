{...}: {
  programs.nixvim = {
    plugins = {
      vimtex.enable = true;
      vimtex.settings.view_method = "zathura";
    };
  };
}

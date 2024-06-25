{ pkgs, lib, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
        nvim-treesitter
        gruvbox
    ];
    extraConfig = ''
        set expandtab
        set tabstop=2
        set softtabstop=2
        set shiftwidth=2
    '';
    extraLuaConfig = ''
    '';
		viAlias = true;
		vimAlias = true;
		vimdiffAlias = true;

  };
}

{ ... } :
{
  imports = [
    ./options.nix
    ./plugins.nix
    ./keymap.nix
  ];

  home.shellAliases.v = "nvim";

  programs.nixvim = {
    enable = true;

    clipboard.register = "unnamedplus";

    colorschemes.tokyonight = {
      enable = true;
      settings = {
        transparent = true;
        on_colors = ''
        function(colors)
          colors.bg = colors.none
          colors.bg_dark = colors.none
          colors.bg_float = colors.none
          colors.bg_search = colors.none
          colors.bg_sidebar = colors.none
          colors.bg_statusline = colors.none
        end
        '';
      };
    };
  };
}

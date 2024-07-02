{ pkgs, ... } :
{
  imports = [
    ./options.nix
    ./plugins.nix
    ./keymap.nix
  ];

  home.packages = [
    pkgs.ripgrep
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
    autoCmd = [
      # Vertically center document when entering insert mode
      {
        event = "InsertEnter";
        command = "norm zz";
      }

      # Open help in a vertical split
      {
        event = "FileType";
        pattern = "help";
        command = "wincmd L";
      }

      # Enable spellcheck for some filetypes
      {
        event = "FileType";
        pattern = [
          "tex"
          "latex"
          "markdown"
        ];
        command = "setlocal spell spelllang=en,de";
      }
    ];
  };
}

{
  pkgs,
  inputs,
  ...
}: {
  # not gonna document nixvim because i dont really understand most of it,
  # just copied other peoples stuff until it did what i wanted it to do
  # (mostly taken from the examples in the nixvim docu)
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./plugins
    ./options.nix
    ./keymap.nix
  ];

  stylix.targets.nixvim.enable = false;

  home = {
    shellAliases.v = "nvim";
    sessionVariables.EDITOR = "nvim";
    packages = with pkgs; [
      ripgrep
    ];
  };

  programs.nixvim = {
    enable = true;

    clipboard.register = "unnamedplus";

    colorschemes.tokyonight = {
      enable = true;
      settings = {
        transparent = true;
        # actual transparency
        on_colors = ''
          function(colors)
              colors.bg = colors.none
              colors.bg_dark = colors.none
              colors.bg_float = colors.none
              colors.bg_search = colors.none
              -- one day this started to make it crash D:
              -- colors.bg_sidebar = colors.none
              colors.bg_statusline = colors.none
          end
        '';
      };
    };

    extraConfigLua = ''
      vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = "#9d7cd8", bg = "none"})
      vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = "#9ece6a", bg = "none"})
      vim.api.nvim_set_hl(0, "FloatermBorder", { fg = "#9d7cd8", bg = "none"})
      vim.filetype.add({extension = { purs = 'purescript' } })
      vim.g.closetag_filenames = '*.html,*.xhtml,*.phtml'
      vim.g.closetag_xhtml_filenames = '*.xhtml,*.jsx,*.svelte,*.xml'
      vim.g.closetag_filetypes = 'html,xhtml,phtml,svelte,xml'
      vim.g.closetag_xhtml_filetypes = 'xhtml,jsx,svelte,xml'
    '';

    autoCmd = [
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
        command = "setlocal spell spelllang=en";
      }
      # Enable spellcheck for some filetypes
      {
        event = "FileType";
        pattern = [
          "nix"
        ];
        command = "setlocal shiftwidth=2 tabstop=2 softtabstop=2";
      }
    ];
  };
}

{ pkgs, ... } :
{
    imports = [
        ./plugins
        ./options.nix
        ./keymap.nix
    ];

    home = {
        shellAliases.v = "nvim";
        sessionVariables.EDITOR = "nvim";
        packages = with pkgs; [
            ripgrep
            haskell-language-server
        ];
    };

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
            vim.g.closetag_xhtml_filenames = '*.xhtml,*.jsx,*.svelte'
            vim.g.closetag_filetypes = 'html,xhtml,phtml,svelte'
            vim.g.closetag_xhtml_filetypes = 'xhtml,jsx,svelte'
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
        ];
    };
}

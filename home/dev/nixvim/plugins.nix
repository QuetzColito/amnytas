{ pkgs, ... } :
{
    imports = [
        ./plugins/telescope.nix
        ./plugins/lsp.nix
        ./plugins/treesitter.nix
        ./plugins/cmp.nix
        ./plugins/neotree.nix
        ./plugins/markdown.nix
        ./plugins/lazygit.nix
    ];

    programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
        vim-closetag
    ];

    programs.nixvim.plugins = {
        nvim-autopairs.enable = true;
        transparent.enable = true;
        luasnip.enable = true;

        gitsigns = {
            enable = true;
            settings.signs = {
                add.text = "+";
                change.text = "~";
            };
        };

        nvim-colorizer = {
            enable = true;
            userDefaultOptions.names = false;
        };

        oil.enable = true;

        trim = {
            enable = true;
            settings = {
                highlight = true;
                ft_blocklist = [
                    "checkhealth"
                    "floaterm"
                    "lspinfo"
                    "neo-tree"
                    "TelescopePrompt"
                ];
            };
        };

        comment = {
            enable = true;
            settings = {
                opleader.line = "<C-/>";
                toggler.line = "<C-/>";
            };
        };

        lualine.enable = true;

        floaterm = {
            enable = true;
            shell = "zsh";
            keymaps = {
                toggle = "<C-L>";
                next = "<C-J>";
                prev = "<C-K>";
                new = "<C-H>";
            };
            width = 0.8;
            height = 0.8;
            title = "";
        };
    };
}

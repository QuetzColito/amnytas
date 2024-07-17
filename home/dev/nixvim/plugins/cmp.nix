{ ... } :
{
    programs.nixvim.opts.completeopt = ["menu" "menuone" "noselect"];

    programs.nixvim.plugins = {
        luasnip.enable = true;

        lspkind = {
            enable = true;

            cmp = {
                enable = true;
                menu = {
                    nvim_lsp = "[LSP]";
                    nvim_lua = "[api]";
                    path = "[path]";
                    luasnip = "[snip]";
                    buffer = "[buffer]";
                };
            };
        };

        cmp = {
            enable = true;

            settings = {
                snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
                mapping = {
                    "<C-d>" = "cmp.mapping.scroll_docs(-4)";
                    "<C-f>" = "cmp.mapping.scroll_docs(4)";
                    "<C-Space>" = "cmp.mapping.complete()";
                    "<C-e>" = "cmp.mapping.close()";
                    "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
                    "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
                    "<CR>" = "cmp.mapping.confirm({ select = true })";
                };

                sources = [
                    { name = "path"; }
                    { name = "nvim_lsp"; }
                    { name = "luasnip"; }
                    {
                        name = "buffer";
                        option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
                    }
                ];
            };
        };
    };
}

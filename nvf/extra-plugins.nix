{pkgs, ...}: {
  config.vim.extraPlugins = {
    oil = {
      package = pkgs.vimPlugins.oil-nvim;
      setup = "require('oil').setup()";
    };
    trim = {
      package = pkgs.vimPlugins.trim-nvim;
      setup = ''
        require('trim').setup({
          ft_blocklist = {
            "checkhealth",
            "floaterm",
            "lspinfo",
            "TelescopePrompt"
            },

          patterns = {
            [[%s/\(\n\n\)\n\+/\1/]],   -- replace multiple blank lines with a single line
          },

          trim_on_write = true,

          highlight = true
        })
      '';
    };
  };
}

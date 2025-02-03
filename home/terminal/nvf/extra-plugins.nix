{pkgs, ...}: {
  programs.nvf.settings.vim.extraPlugins = with pkgs.vimPlugins; {
    oil = {
      package = oil-nvim;
      setup = "require('oil').setup()";
    };
    trim = {
      package = trim-nvim;
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

          trim_on_write = false,

          highlight = true
        })
      '';
    };
  };
}

{ ... } :
{
  programs.nixvim = {
    plugins.telescope = {
      enable = true;

      keymaps = {
        "<leader>f" = "find_files";
        # "<leader>fg" = "live_grep";
        "<leader>b" = "buffers";
        "<C-m>" = "help_tags";
        "<leader>d" = "diagnostics";

        "<C-p>" = "git_files";
        "<leader>p" = "oldfiles";
        "<C-f>" = "live_grep";
      };

      settings.defaults = {
        file_ignore_patterns = [
          "^.git/"
          "^.mypy_cache/"
          "^.__pycache__/"
          "^.output/"
          "^.data/"
          "%.ipynb"
        ];
        set_env.COLORTERM = "truecolor";
      };
    };
  };
}

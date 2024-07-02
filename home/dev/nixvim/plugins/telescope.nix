{ ... } :
{
  programs.nixvim = {
    plugins.telescope = {
      enable = true;

      keymaps = {
        "<leader>ff" = "find_files";
        "<leader>fg" = "find_files";
        "<leader>b" = "find_files";
        "<leader>fh" = "find_files";
        "<leader>fd" = "find_files";

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


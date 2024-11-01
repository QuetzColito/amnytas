{
  config,
  pkgs,
  lib,
  ...
}: {
  home = {
    shellAliases = {
      nd = "nix develop -c nu";
      nix-shell = "nix-shell --command nu";
      ll = "ls";
      lt = "eza --tree";
      ls = "eza";
    };

    sessionVariables.SHELL = "nu";
  };
  programs.nushell = {
    enable = true;
    shellAliases = config.home.shellAliases;
    environmentVariables = {
      PROMPT_INDICATOR_VI_INSERT = "";
      PROMPT_INDICATOR_VI_NORMAL = "";
      SHELL = config.home.sessionVariables.SHELL;
      EDITOR = config.home.sessionVariables.EDITOR;
    };
    # stolen from Aylur
    extraConfig = let
      conf = builtins.toJSON {
        show_banner = false;
        edit_mode = "vi";

        highlight_resolved_externals = true;

        table = {
          mode = "compact"; # compact thin rounded
          index_mode = "always"; # alway never auto
          header_on_separator = false;
        };

        cursor_shape = {
          vi_insert = "line";
          vi_normal = "block";
        };

        menus = [
          {
            name = "completion_menu";
            only_buffer_difference = false;
            marker = "? ";
            type = {
              layout = "columnar"; # list, description
              columns = 4;
              col_padding = 2;
            };
            style = {
              text = "magenta";
              selected_text = "blue_reverse";
              description_text = "yellow";
            };
          }
        ];
      };
      completions = let
        completion = name: ''
          source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/${name}/${name}-completions.nu
        '';
      in
        names:
          builtins.foldl'
          (prev: str: "${prev}\n${str}") ""
          (map (name: completion name) names);
    in ''
      $env.config = ${conf};
      ${completions ["cargo" "git" "nix" "npm" "curl"]}
    '';
  };
}

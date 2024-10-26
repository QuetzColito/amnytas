{
  lib,
  pkgs,
  config,
  ...
}: let
  user = config.home.username;
  host = config.hostName;
in {
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;

        keymaps = {
          silent = true;
          diagnostic = {
            "<leader>k" = "goto_prev";
            "<leader>j" = "goto_next";
          };

          lspBuf = {
            gd = "definition";
            gD = "references";
            gt = "type_definition";
            gi = "implementation";
            ca = "code_action";
            K = "hover";
            "<F2>" = "rename";
          };
        };

        servers = {
          nixd = {
            enable = true;

            settings = {
              nixpkgs.expr = "import <nixpkgs> { }";
              formatting.command = ["${lib.getExe pkgs.alejandra}"];
              options = {
                nixos.expr = "(builtins.getFlake \"/home/${user}/amnytas\").nixosConfigurations.${host}.options";
                home-manager.expr = "(builtins.getFlake \"/home/${user}/amnytas\").homeConfigurations.${user}.options";
              };
            };
          };
          svelte.enable = true;
          hls = {
            enable = true;
            # installGhc = true;
          };
          ts-ls.enable = true;

          rust-analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
            settings.rustfmt.overrideCommand = ["${lib.getExe pkgs.rustfmt}"];
          };

          # java-language-server = {
          #     enable = true;
          #     rootDir = "function() return vim.uv.cwd() end";
          # };

          efm = {
            enable = true;
            extraOptions.init_options = {
              documentFormatting = true;
              documentRangeFormatting = true;
              hover = true;
              documentSymbol = true;
              codeAction = true;
              completion = true;
            };
          };
        };
      };

      lsp-format = {
        enable = true;
      };

      efmls-configs.enable = true;
    };
  };
}

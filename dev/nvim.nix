{ pkgs, lib, ... }:
let
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
    # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
    # ref = "nixos-23.05";
  });
in
{
  imports = [
    nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;

    # Theme
    colorschemes.tokyonight = {
      enable = true;
      settings = {
        style = "night";
        transparent = true;
      };
    };

    # Plugins
    plugins = {
      telescope.enable = true;
      oil.enable = true;
      treesitter.enable = true;
      luasnip.enable = true;
    };

    plugins.cmp = {
      enable = true;
      autoEnableSources = true;
    };

    plugins.lsp = {
      enable = true;
      
      servers = {
	java-language-server.enable = true;
        hls.enable = true;
        rust-analyzer.enable = true;
	rust-analyzer.installCargo = false;
	rust-analyzer.installRustc = false;
      };
    };

    keymaps = [
      {
	action = "<cmd>Telescope live_grep<CR>";
	key = "<leader>g";
      }
    ];

    # Settings
    globals.mapleader = " ";
    opts = {
      number = true;         # Show line numbers
      relativenumber = true; # Show relative line numbers

      shiftwidth = 2;        # Tab width should be 2
    };
  };
}

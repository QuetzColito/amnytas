{ ... } :
{
  imports = [
    ./options.nix
    ./plugins.nix
    ./keymap.nix
  ];

  programs.nixvim = {
    enable = true;

    

    clipboard.register = "unnamedplus";

    colorschemes.tokyonight = {
      enable = true;
      settings = {
        transparent = true;
      };
    };
  };
}

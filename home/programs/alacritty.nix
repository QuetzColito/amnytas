{
  pkgs,
  config,
  ...
}:

{
    programs.alacritty = {
        enable = true;
        settings = {
            shell.program = "${config.home.homeDirectory}/.nix-profile/bin/zsh";
            window = {
                blur = false;
            };
        };
    };

    home.packages = with pkgs; [
        ueberzugpp
    ];
}

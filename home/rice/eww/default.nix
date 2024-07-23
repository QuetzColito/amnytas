{
  pkgs,
  ...
} : {
    # programs.eww = {
    #     enable = true;
    #     configDir = ./.;
    # };
    home.packages = [ pkgs.eww ];
}

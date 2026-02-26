{
  pkgs,
  theme,
  ...
}: {
  imports = [
    ./hypr
    ./tofi.nix
    ./quickshell.nix
    ./scripts.nix
    ./scripts
  ];

  services.hypridle.enable = true;

  files = {
    # Ags colors
    ".config/stylix/colours.scss".text = builtins.concatStringsSep "\n" (builtins.attrValues (builtins.mapAttrs
      (name: value:
        "$"
        + "${name}: #${value};")
      theme.colours));
  };

  packages = with pkgs; [
    brightnessctl
    slurp
    grim
    hyprpicker
    grimblast
    wl-clipboard
    playerctl
    pwvucontrol
    socat
    killall
    swappy
  ];
}

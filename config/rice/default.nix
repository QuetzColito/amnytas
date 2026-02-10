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
    xorg.xrandr
    xorg.setxkbmap
    brightnessctl
    slurp
    grim
    hyprpicker
    grimblast
    # bibata-cursors
    wl-clip-persist
    wl-clipboard
    xclip
    # pngquant
    # cliphist
    clipnotify
    playerctl
    pamixer
    pavucontrol
    pwvucontrol
    socat
    killall
    swappy
  ];
}

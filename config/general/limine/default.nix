{
  lib,
  config,
  theme,
  pkgs,
  ...
}: {
  options = {
    wantLimine = lib.mkEnableOption "add Limine config (needs to be manually generated and selected in bios)";
  };

  # run nixos-rebuild with --install-bootloader once
  # then select Limine in bios
  config = lib.mkIf config.wantLimine {
    boot.loader = {
      systemd-boot.enable = lib.mkForce false;
      limine = {
        enable = true;
        # # edit this if you want to keep more configs
        maxGenerations = 5;
        style = {
          wallpapers = [../../../wallpaper/boot.png];
          wallpaperStyle = "centered";
          graphicalTerminal = {
            palette = "${theme.base00};${theme.base08};${theme.base0B};${theme.base0A};${theme.base0D};${theme.base0E};${theme.base0C};${theme.base04}";
            foreground = theme.base04;
            background = "40${theme.base00}";
            margin = 0;
            marginGradient = 0; # TODO: figure out the difference
          };
          interface.branding = "A Cozy Operating System";
          backdrop = theme.base00;
        };
      };
    };

    # Secure Boot
    environment.systemPackages = [pkgs.sbctl];
    boot.loader.limine.secureBoot.enable = true;
  };
}

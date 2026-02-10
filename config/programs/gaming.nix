{
  inputs,
  config,
  theme,
  pkgs,
  ...
}: {
  # ntsync
  boot.kernelModules = ["ntsync"];
  environment.variables.PROTON_USE_NTSYNC = "1";
  services.udev.extraRules = ''
    KERNEL=="ntsync", MODE="0644"
  '';

  # HSR on Linux :>
  imports = [inputs.aagl.nixosModules.default];
  nix.settings = inputs.aagl.nixConfig; # Set up Cachix
  # Dont try to add hsr before setting up cachix, unless you want to compile it
  programs.honkers-railway-launcher.enable = !config.firstInstall;
  programs.anime-game-launcher.enable = !config.firstInstall;

  programs.steam = {
    enable = true;
    extraPackages = [theme.cursor.package]; # >.>
    protontricks.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = [pkgs.proton-ge-bin];
  };

  programs.ydotool.enable = true;

  programs.gamescope.enable = true;

  packages = with pkgs; [
    wineWowPackages.full
    winetricks
    bottles
    gamemode
    osu-lazer-bin
    prismlauncher
    heroic
    xivlauncher
    vkbasalt
    # (pkgs.writeShellScriptBin "poetrade" ''appimage-run /home/quetz/apps/Awakened-PoE-Trade.Appimage'')
    (writeShellScriptBin "poetrade" "XDG_SESSION_TYPE='x11' appimage-run ${inputs.poetrade}")
    (writeShellScriptBin "arknights" "waydroid app launch com.YoStarEN.Arknights")
  ];
}

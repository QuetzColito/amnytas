{
  inputs,
  config,
  theme,
  pkgs,
  ...
}: {
  # HSR on Linux :>
  imports = [inputs.aagl.nixosModules.default];
  nix.settings = inputs.aagl.nixConfig; # Set up Cachix
  # Dont try to add hsr before setting up cachix, unless you want to compile it
  programs.honkers-railway-launcher.enable = !config.firstInstall;

  programs.steam = {
    enable = true;
    extraPackages = [theme.cursor.package]; # >.>
    protontricks.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = [pkgs.proton-ge-bin];
  };

  packages = with pkgs; [
    gamescope
    gamemode
    path-of-building
    osu-lazer-bin
    prismlauncher
    heroic
    xivlauncher
    vkbasalt
  ];
}

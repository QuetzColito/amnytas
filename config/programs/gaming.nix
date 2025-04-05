{
  inputs,
  config,
  pkgs,
  ...
}: {
  # HSR on Linux :>
  imports = [inputs.aagl.nixosModules.default];
  nix.settings = inputs.aagl.nixConfig; # Set up Cachix
  programs.honkers-railway-launcher.enable = !config.firstInstall;

  programs.steam = {
    enable = true;
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

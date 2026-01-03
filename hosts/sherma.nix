{
  inputs,
  pkgs,
  ...
}: {
  wantGrub = true;
  enableBluetooth = true;

  imports = [
    inputs.hardware.nixosModules.framework-12-13th-gen-intel
  ];

  programs.hyprland = {
    plugins = with inputs.hyprland-plugins.${pkgs.stdenv.hostPlatform.system}; [
      # There should be hyprgrass here, but doesnt build rn
    ];
  };

  system.stateVersion = "25.11"; # Did you read the comment?
  virtualisation.waydroid.enable = true;

  monitors = [
    {
      name = "DP-3";
      coords = "-1920x0";
      workspaces = [4 5 6];
    }
    {
      name = "eDP-1";
      coords = "0x0";
      workspaces = [1 2 3 7 8 9];
    }
  ];

  services.upower.enable = true;
}

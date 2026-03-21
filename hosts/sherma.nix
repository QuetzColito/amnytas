{inputs, ...}: {
  wantLimine = true;
  enableBluetooth = true;

  imports = [
    inputs.hardware.nixosModules.framework-12-13th-gen-intel
  ];

  # programs.hyprland = {
  #   plugins = with inputs.hyprland-plugins.${pkgs.stdenv.hostPlatform.system}; [
  #     # There should be hyprgrass here, but doesnt build rn
  #   ];
  # };

  system.stateVersion = "25.11"; # Did you read the comment?
  virtualisation.waydroid.enable = true;

  services.upower.enable = true;
}

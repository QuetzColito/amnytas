{pkgs, ...}: {
  isNvidia = true;
  wantGrub = true;

  system.stateVersion = "23.11"; # Did you read the comment?

  # Optimus prime because laptop
  hardware.nvidia.prime = {
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };

    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  packages = with pkgs; [
    (writeShellScriptBin "nvidia-offload" ''
      export __NV_PRIME_RENDER_OFFLOAD=1
      export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
      export __VK_LAYER_NV_optimus=NVIDIA_only
      exec "$@"
    '')
    acpi
  ];

  # TODO: reintegrate into config
  # # Touchpad too slo
  # wayland.windowManager.hyprland.settings = {
  #   device = {
  #     name = "elan050a:01-04f3:3158-touchpad";
  #     sensitivity = "+1.0";
  #   };
  # };

  monitors = [
    {
      name = "eDP-1";
      coords = "0x0";
      workspaces = [1 2 3 7 8 9];
    }
    {
      name = "HDMI-A-1";
      coords = "-1920x0";
      workspaces = [4 5 6];
    }
  ];

  services.upower.enable = true;
}

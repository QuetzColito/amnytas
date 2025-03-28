{pkgs, ...}: {
  home = {
    stateVersion = "23.11"; # Please read the comment before changing.

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

    shellAliases.hss = "home-manager switch --flake ~/amnytas#arthezia-mobile";
  };

  programs.git.extraConfig.user = {
    email = "stefan.lahne@proton.me";
    name = "Stefan Lahne";
  };

  isNvidia = true;

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

  # Touchpad too slo
  wayland.windowManager.hyprland.settings = {
    device = {
      name = "elan050a:01-04f3:3158-touchpad";
      sensitivity = "+1.0";
    };
  };
}

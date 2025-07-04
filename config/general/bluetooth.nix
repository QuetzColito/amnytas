{
  lib,
  config,
  ...
}: {
  options.enableBluetooth = lib.mkEnableOption "enables bluetooth support";

  # bluptup
  config = lib.mkIf config.enableBluetooth {
    # backend
    hardware.bluetooth.enable = true;
    # applet and gui
    services.blueman.enable = config.wm == "Hyprland";

    hardware.bluetooth.settings = {
      # In theory dual should work since it includes bredr,
      # but apparently something breaks and I only get audio on one ear
      General = {
        ControllerMode = "bredr";
      };
    };
  };
}

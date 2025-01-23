{
  config,
  lib,
  ...
}: {
  options.isNvidia = lib.mkEnableOption "enables nvidia config/drivers";

  # Copied from https://nixos.wiki/wiki/Nvidia
  config = lib.mkIf config.isNvidia {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {
      modesetting.enable = true;

      powerManagement.enable = false;
      powerManagement.finegrained = false;

      open = false;

      nvidiaSettings = true;

      # using stable since it has explicit sync now
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
  };
}

{
  config,
  lib,
  ...
} : {
    options.isNvidia = lib.mkEnableOption "enables nvidia config/drivers";

    config = lib.mkIf config.isNvidia {
        hardware.graphics = {
            enable = true;
            enable32Bit = true;
        };

        services.xserver.videoDrivers = [ "nvidia" ];

        hardware.nvidia = {
            modesetting.enable = true;

            powerManagement.enable = false;
            powerManagement.finegrained = false;

            open = true;

            nvidiaSettings = true;

            package = config.boot.kernelPackages.nvidiaPackages.stable;
        };
    };
}

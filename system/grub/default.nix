{
  lib,
  config,
  ...
} : {
    options = {
        wantGrub = lib.mkEnableOption "add grub config (needs to be manually generated and selected in bios)";
    };

    config = lib.mkIf config.wantGrub {
        boot.loader = {
            systemd-boot.enable = lib.mkForce false;
            efi = {
                canTouchEfiVariables = true;
                efiSysMountPoint = "/boot";
            };
            grub = {
                theme =  lib.mkForce ./.;
                gfxmodeEfi = "2560x1440x32,1920x1080x24,auto";
                devices = [ "nodev" ];
                enable = true;
                efiSupport = true;
                useOSProber = true;
                configurationLimit = 2;
            };
        };
    };
}

{config, lib, ...}:
{  # Bootloader.
  boot.loader = {
    systemd-boot.enable = lib.mkForce false;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      theme =  lib.mkForce ../grub;
      gfxmodeEfi = "2560x1440x32,1920x1080x24,auto";
      devices = [ "nodev" ];
      enable = true;
      efiSupport = true;
      useOSProber = true;
    };
  };

  networking.hostName = "mabon"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.wireless.networks."uni-halle" = {
    auth = (builtins.readFile /etc/nixos/wpa.txt);
  };


  # Nvidia
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement.enable = false;
    powerManagement.finegrained = false;

    open = false;

    prime = {
        offload = {
            enable = true;
            enableOffloadCmd = true;
        };

        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
    };


    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.arthezia = {
    isNormalUser = true;
    description = "arthezia";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = [];
  };
}

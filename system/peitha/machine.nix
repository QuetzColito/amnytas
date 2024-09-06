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

  networking.hostName = "peitha"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  programs.nm-applet.enable = true;
  networking.networkmanager.enable = true;

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

    open = true;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.quetz = {
    isNormalUser = true;
    description = "quetz";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = [];
  };
}

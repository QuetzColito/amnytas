{config, ...}:
{  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "mabon"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.



  # Nvidia
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
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
  users.users.arthezia = {
    isNormalUser = true;
    description = "arthezia";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = [];
  };
}
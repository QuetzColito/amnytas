{config, ...}:
{  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "zojja"; # Define your hostname.
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

    open = false;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.melon = {
    isNormalUser = true;
    description = "melon";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = [];
  };
}

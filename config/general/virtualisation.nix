{pkgs, ...}: {
  # Qemu for VMs
  environment.systemPackages = with pkgs; [
    qemu
    quickemu
  ];

  # Docker
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  virtualisation.waydroid = {
    enable = true;
    # necessary because kernel >= 6.17
    package = pkgs.waydroid-nftables;
  };
}

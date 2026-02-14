{pkgs, ...}: {
  # Qemu for VMs
  environment.systemPackages = with pkgs; [
    qemu
    quickemu
    distrobox
  ];

  virtualisation = {
    # Docker
    docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };

    # Waydroid
    waydroid = {
      enable = true;
      # necessary because kernel >= 6.17
      package = pkgs.waydroid-nftables;
    };

    # Distrobox
    podman = {
      enable = true;
      dockerCompat = true;
    };
  };
}

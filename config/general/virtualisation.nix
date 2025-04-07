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
}

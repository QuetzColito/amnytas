{pkgs, ...}: {
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

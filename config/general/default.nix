{...}: {
  imports = [
    ./locale.nix
    ./virtualisation.nix
    ./nvidia.nix
    ./theming.nix
    ./grub
  ];
}

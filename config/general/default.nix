{...}: {
  imports = [
    ./locale.nix
    ./virtualisation.nix
    ./bluetooth.nix
    ./nvidia.nix
    ./theming.nix
    ./grub
  ];
}

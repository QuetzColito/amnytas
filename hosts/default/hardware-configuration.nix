{...}: {
  # either leave it like this (maybe needs --impure then?) or replace this file with your hardware config
  imports = [
    /etc/nixos/hardware-configuration.nix
  ];
}

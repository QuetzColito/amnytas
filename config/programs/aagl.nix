{
  inputs,
  config,
  ...
}: {
  # HSR on Linux :>
  imports = [inputs.aagl.nixosModules.default];
  nix.settings = inputs.aagl.nixConfig; # Set up Cachix
  programs.honkers-railway-launcher.enable = !config.firstInstall;
}

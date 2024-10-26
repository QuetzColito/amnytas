# --- Cosmic, tried it out once, maybe one day ill switch to it
# But probably only if it gets to a point where i can replicate
# my Hyprland config with it
{
  inputs,
  lib,
  config,
  ...
}: {
  imports = [inputs.nixos-cosmic.nixosModules.default];

  nix.settings = {
    substituters = ["https://cosmic.cachix.org/"];
    trusted-public-keys = ["cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="];
  };

  services = lib.mkIf (config.wm == "Cosmic") {
    desktopManager.cosmic.enable = true;
    displayManager.cosmic-greeter.enable = true;
  };
}

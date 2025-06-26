{
  lib,
  self,
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [
    ../config/hjem.nix
    ../config/terminal
  ];

  config = {
    environment.systemPackages = with pkgs; [
      vim
      wget
      git
    ];
    system.stateVersion = "25.11"; # Did you read the comment?
    packages = [
      self.packages.${pkgs.stdenv.system}.nvf
    ];
    users.users.${config.mainUser} = {
      isNormalUser = true;
      shell = pkgs.zsh;
      description = config.mainUser;
      extraGroups = ["networkmanager" "wheel"];
      packages = [];
    };

    nixpkgs.config.allowUnfree = true;
    nix = {
      settings.experimental-features = ["nix-command" "flakes"];
      nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    };
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/${config.mainUser}/amnytas";
    };
  };
  options = {
    mainUser = lib.mkOption {
      default = "nixos";
      type = lib.types.str;
    };

    hostName = lib.mkOption {
      default = "nixos";
      type = lib.types.str;
    };
  };
}

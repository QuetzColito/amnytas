{lib, ...}: {
  imports = [
    ../config/hjem.nix
    ../config/terminal
  ];

  config = {
    system.stateVersion = "25.11"; # Did you read the comment?
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

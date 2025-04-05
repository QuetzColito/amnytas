{
  inputs,
  config,
  lib,
  ...
}: {
  options = {
    files = lib.mkOption {
      default = {};
      type = lib.types.attrs;
    };
    packages = lib.mkOption {
      default = [];
      type = lib.types.listOf lib.types.package;
    };
  };

  imports = [
    inputs.hjem.nixosModules.default
  ];

  config = {
    hjem.clobberByDefault = true;
    hjem.users.${config.mainUser} = {
      enable = true;
      user = config.mainUser;
      directory = "/home/${config.mainUser}";
      inherit (config) files;
    };

    users.users.${config.mainUser} = {inherit (config) packages;};
  };
}

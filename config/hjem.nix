{
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

  config = {
    hjem.clobberByDefault = true;
    hjem.users.${config.mainUser} = {
      enable = true;
      user = "quetz";
      directory = "/home/quetz";
      inherit (config) files;
    };

    users.users.${config.mainUser} = {inherit (config) packages;};
  };
}

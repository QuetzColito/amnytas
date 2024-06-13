{
  config,
  ...
} : {
  services.xremap = {
    /* NOTE: since this sample configuration does not have any DE, xremap needs to be started manually by systemctl --user start xremap */
    serviceMode = "user";
    userName = builtins.head (builtins.attrNames config.users.users);

    # Modmap for single key rebinds
    config.modmap = [
      {
        name = "Global";
        remap = { 
          "CapsLock" = "Esc"; # globally remap CapsLock to Esc
        }; 
      }
    ];

    withWlroots = true;

    # Keymap for key combo rebinds
    config.keymap = [
      #{
      #  name = "Example ctrl-u > pageup rebind";
      #  remap = { "C-u" = "PAGEUP"; };
      #}
    ];
  };
}
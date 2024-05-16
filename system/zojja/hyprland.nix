{
  ...
}: {
  imports = [
    ../wm/hyprland.nix
  ];
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "";
        user = "melon";
      };
    default_session = initial_session;
    };
  };
}

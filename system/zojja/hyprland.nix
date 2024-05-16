{
  ...
}: {
  imports = [
    ../wm/hyprland.nix
  ];
  services.greetd = {
    enable = false;
    settings = rec {
      initial_session = {
        command = "Hyprland";
        user = "melon";
      };
    default_session = initial_session;
    };
  };
}

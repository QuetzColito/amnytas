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
        command = "Hyprland";
        user = "arthezia";
      };
    default_session = initial_session;
    };
  };
}
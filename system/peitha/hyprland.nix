{
  ...
}: {
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "Hyprland";
        user = "quetz";
      };
    default_session = initial_session;
    };
  };
}
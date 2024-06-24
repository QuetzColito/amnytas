{ lib, ... }: {
    # Requires libnotify
    services.mako = {
      enable = true;
      backgroundColor = "#282828";
      textColor = "#ebdbb2";
      borderColor = "#32302f";
      progressColor = "over #414559";
      borderRadius = 10;
      defaultTimeout = 5000;
      padding = "10";
      extraConfig = "
text-alignment=center
[urgency=low]
default-timeout=2500
[urgency=high]
text-color=#fb4934
border-color=#fb4934
default-timeout=0
";
    };
}

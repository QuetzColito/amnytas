{...}: {
  # This is what sane defaults looks like o.o
  programs.foot = {
    enable = true;
    settings.main.shell = "nu";
  };

  home.sessionVariables = {
    TERMINAL = "foot";
  };
}

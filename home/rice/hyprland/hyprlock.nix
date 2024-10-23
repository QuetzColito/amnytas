{config, ...}: let
  anchored = x: y: (builtins.toString (x - 25)) + ", " + (builtins.toString (y + 0));
in {
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        # hide_cursor = true;
        grace = 60;
      };
      # take the wallpaper of the first workspace per monitor
      background = map ({
          name,
          workspaces,
          ...
        } @ self: {
          monitor = name;
          path =
            if (self ? wallpaper)
            then self.wallpaper
            else
              builtins.head (map (
                  id: "~/amnytas/wallpaper/${builtins.toString id}${
                    if (self ? rotation)
                    then "v"
                    else ""
                  }.png"
                )
                workspaces);
          blur_passes = 0;
          blur_size = 2;
          new_optimizations = true;
          ignore_opacity = false;
        })
      config.monitors;

      input-field = {
        monitor = "";
        size = "190, 30";
        outline_thickness = 2;
        dots_size = 0.33; # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.15; # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = false;
        outer_color = "rgba(40,40,40,0.0)";
        inner_color = "rgba(200, 200, 200, 0.8)";
        font_color = "rgba(10, 10, 10, 0.8)";
        fade_on_empty = false;
        placeholder_text = ""; # Text rendered in the input box when it's empty.
        hide_input = false;

        position = anchored 0 (-125);
        halign = "right";
        valign = "center";
      };

      shape = {
        monitor = "";
        size = "320, 2160";
        color = "rgba(${config.stylix.base16Scheme.base01}A0)";
        position = "0, 0";
        halign = "right";
        valign = "top";
      };

      label = [
        {
          # DATE #
          monitor = "";
          text = ''cmd[update:1000] echo "<span>$(date '+%A, %d %B')</span>"'';
          color = "rgba(250, 250, 250, 0.8)";
          font_size = 12;
          font_family = "Inter Display";

          position = anchored 0 40;
          halign = "right";
          valign = "center";
        }

        {
          # TIME #
          monitor = "";
          text = ''cmd[update:1000] echo "<span>$(date '+%H:%M')</span>"'';
          color = "rgba(250, 250, 250, 0.8)";
          font_size = 75;
          font_family = "Inter Display Bold";

          position = anchored 0 100;
          halign = "right";
          valign = "center";
        }

        {
          # USER #
          monitor = "";
          text = "   $USER";
          color = "rgba(200, 200, 200, 1.0)";
          font_size = 18;
          font_family = "Inter Display Medium";

          position = anchored 0 (-75);
          halign = "right";
          valign = "center";
        }
      ];
    };
  };
}

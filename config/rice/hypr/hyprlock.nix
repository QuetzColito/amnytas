{
  config,
  theme,
  pkgs,
  ...
}: let
  anchored = x: y: (builtins.toString (x - 25)) + ", " + (builtins.toString (y + 0));
in {
  packages = [pkgs.hyprlock];

  # dont remove
  security.pam.services.hyprlock = {};

  files.".config/hypr/hyprlock.conf".text = with theme;
    ''
      general {
        grace = 60
      }
      input-field {
        monitor =
        size = 190, 30
        outline_thickness = 2
        dots_size = 0.33 # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.15 # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = false
        outer_color = rgb(${base03});
        inner_color = rgb(${base00});
        font_color = rgb(${base05});
        fail_color = rgb(${base08});
        check_color = rgb(${base0A});
        fade_on_empty = false
        placeholder_text = # Text rendered in the input box when it's empty.
        hide_input = false

        position = ${anchored 0 (-125)}
        halign = right
        valign = center
      }

      shape {
        monitor =
        size = 320, 2160
        color = rgba(${base01}A0)
        position = 0, 0
        halign = right
        valign = top
      }

      label {
        # DATE #
        monitor =
        text = cmd[update:1000] echo "<span>$(date '+%A, %d %B')</span>"
        color = rgb(${base05})
        font_size = 12
        font_family = Inter Display

        position = ${anchored 0 40}
        halign = right
        valign = center
      }

      label {
        # TIME #
        monitor =
        text = cmd[update:1000] echo "<span>$(date '+%H:%M')</span>"
        color = rgb(${base05})
        font_size = 75
        font_family = Inter Display Bold

        position = ${anchored 0 100}
        halign = right
        valign = center
      }

      label {
        # USER #
        monitor =
        text =    $USER
        color = rgb(${base05})
        font_size = 18
        font_family = Inter Display Medium

        position = ${anchored 0 (-75)}
        halign = right
        valign = center
      }
    ''
    + builtins.concatStringsSep "\n"
    (map ({
        name,
        workspaces,
        ...
      } @ self: ''
        background {
            path = ${
          if (self ? wallpaper)
          then self.wallpaper
          else
            builtins.head (map (id: "~/amnytas/wallpaper/${builtins.toString id}${
                if (self ? rotation)
                then "v"
                else ""
              }.png")
              workspaces)
        }
            monitor = ${name}
            blur_passes = 0
            blur_size = 2
          }
      '')
    config.monitors);
}

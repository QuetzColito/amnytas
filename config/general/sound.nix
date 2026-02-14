{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  security.rtkit.enable = true;
  services = {
    # Sound
    pipewire = {
      enable = true;
      pulse.enable = true;
      jack.enable = false;
      alsa.enable = true; # required for osu xD
      wireplumber.enable = true;
      # Disable suspend of Toslink output to prevent audio popping.
      wireplumber.extraConfig."99-disable-suspend" = {
        "monitor.alsa.rules" = [
          {
            matches = [
              {
                "node.name" = "~alsa_input.*";
              }
              {
                "node.name" = "~alsa_output.*";
              }
            ];
            actions = {
              update-props = {
                "session.suspend-timeout-seconds" = 0;
              };
            };
          }
        ];
      };

      extraConfig = {
        pipewire."fix-distortion" = {
          "context.properties" = {
            "default.clock.rate" = 48000;
            "default.clock.quantum" = 2048;
            "default.clock.min-quantum" = 2048;
            "default.clock.max-quantum" = 2048;
          };
        };
        pipewire-pulse."fix-distortion" = {
          "pulse.properties" = {
            "pulse.min.req" = "2048/48000";
            "pulse.default.req" = "2048/48000";
            "pulse.max.req" = "2048/48000";
            "pulse.min.quantum" = "2048/48000";
            "pulse.max.quantum" = "2048/48000";
          };
        };
      };
    };
  };
}

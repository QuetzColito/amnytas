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

      # extraConfig = {
      #   pipewire."92-low-latency" = {
      #     "context.properties" = {
      #       "default.clock.rate" = [44100 48000];
      #       "default.clock.quantum" = 32;
      #       "default.clock.min-quantum" = 32;
      #       "default.clock.max-quantum" = 32;
      #     };
      #   };
      #   pipewire-pulse."92-low-latency" = {
      #     # "context.properties" = [
      #     #   {
      #     #     name = "libpipewire-module-protocol-pulse";
      #     #     args = {};
      #     #   }
      #     # ];
      #     "pulse.properties" = {
      #       "pulse.min.req" = "32/48000";
      #       "pulse.default.req" = "32/48000";
      #       "pulse.max.req" = "32/48000";
      #       "pulse.min.quantum" = "32/48000";
      #       "pulse.max.quantum" = "32/48000";
      #     };
      #     # "stream.properties" = {
      #     #   # "node.latency" = "32/48000";
      #     #   # "resample.quality" = 1;
      #     # };
      #   };
      # };
    };
  };
}

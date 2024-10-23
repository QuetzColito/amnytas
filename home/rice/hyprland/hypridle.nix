{...}: {
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = ''hyprlock'';
        ignore_dbus_inhibit = false;
      };

      listener = [
        {
          # after 15 Minutes, start hyprlock (for 60s any activity will unlock it)
          timeout = 900;
          on-timeout = ''loginctl lock-session'';
        }

        {
          # disable monitors 3 Minutes after locking
          # now that i think about it, dont think ive ever seen this work o.o
          timeout = 1020;
          on-timeout = ''hyprctl dispatch dpms off'';
          on-resume = ''hyprctl dispatch dpms on'';
        }
      ];
    };
  };
}

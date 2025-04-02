_: {
  files.".config/hypr/hypridle.conf".text = ''
    general {
      lock_cmd = hyprlock
    }

    listener {
      # after 15 Minutes, start hyprlock (for 60s any activity will unlock it)
      timeout = 900
      on-timeout = loginctl lock-session
    }

    listener {
      # disable monitors 3 Minutes after locking
      # sometimes doesnt work and bar on main monitor is broken after reactivation
      timeout = 1020;
      on-timeout = hyprctl dispatch dpms off;
      on-resume = hyprctl dispatch dpms on;
    }
  '';
}

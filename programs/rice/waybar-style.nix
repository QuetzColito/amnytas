
''
  * {
    border: none;
    border-radius: 0px;
    /* `otf-font-awesome` is required to be installed for icons */
    font-family: "Iosevka Nerd Font";
    font-weight: 600;
    font-size: 14px;
    min-height: 20px;
    opacity: 1.0;
  }

  window#waybar {
    background: none;
  }

  tooltip {
    background: #12121e;
    border-radius: 7px;
    border-width: 2px;
    border-style: solid;
    border-color: #11111b;
    opacity: 1.0;
  }

  #workspaces button {
    padding: 5px;
    color: #313244;
    margin-right: 5px;
  }

  #workspaces button.active {
    color: #89b4fa;
    background: #1e1e2e;
  }

  #workspaces button.focused {
    color: #707880;
    background: #eba0ac;
    border-radius: 7px;
  }

  #workspaces button.urgent {
    color: #11111b;
    background: #f28fad;
    border-radius: 7px;
    opacity: 0.5;
  }

  #workspaces button:hover {
    color: #cdd6f4;
    background: #11111b;
    border-radius: 17px;
  }

  #window,
  #clock,
  #battery,
  #mpris,
  #pulseaudio,
  #custom-pacman,
  #network,
  #bluetooth,
  #temperature,
  #workspaces,
  #tray,
  #mpd,
  #custom-pomodoro,
  #cpu,
  #memory,
  #custom-spotify,

  #backlight {
    border-radius: 7px 0px 0px 7px;
    background: #1e1e2e;
    opacity: 1.0;
    padding: 0px 7px;
    margin-top: 5px;
    margin-bottom: 6px;
  }

  #pulseaudio {
    color: #89b4fa;
    border-radius: 0px;
    border-left: 0px;
    border-radius: 7px 0px 0px 7px;
    border-right: 5px;
    margin-right: -5px;
  }

  #pulseaudio.microphone {
    color: #cba6f7;
    border-left: 0px;
    border-right: 0px;
    border-radius: 0px 7px 7px 0px;
    margin-right: 5px;
  }

  #cpu {
    color: #89cdeb;
    border-radius: 7px 0px 0px 7px;
  }

  #memory {
    color: #94e2d5;
    border-radius: 0px 7px 7px 0px;
    margin-right: 5px;
  }

  #tray {
    border-radius: 7px;
    margin-right: 5px;
  }

  #workspaces {
    background: #1e1e2e;
    border-radius: 7px;
    margin-left: 5px;
    padding-right: 5px;
    padding-left: 5px;
    opacity: 1.0;
  }

  /* #custom-power_profile { */
  /*   color: #a6e3a1; */
  /*   border-left: 0px; */
  /*   border-right: 0px; */
  /* } */

  #window {
    border-radius: 7px;
    margin-left: 10px;
    margin-right: 60px;
    opacity: 1.0;
  }

  #clock {
    color: #fab387;
    border-radius: 7px;
    /* margin-left: 10px; */
    margin-right: 5px;
    /* margin-left: 5px; */
    padding-right: 0px;
    border-right: 0px;
    opacity: 1.0;

  }

  #network {
    color: #f9e2af;
    border-radius: 7px;
    margin-right: 5px;
    border-left: 0px;
    border-right: 0px;
    opacity: 1.0;
  }

  #bluetooth {
    color: #89b4fa;
    border-radius: 7px;
    margin-right: 5px;
    opacity: 1.0;
  }

  #battery {
    color: #a6e3a1;
    border-radius: 7px;
    margin-right: 5px;
    border-left: 0px;
  }

  #custom-spotify {
    border-radius: 7px;
    margin-right: 5px;
    border-right: 0px;
    opacity: 1.0;
  }

  #mpris {
    border-radius: 7px;
    margin-right: 5px;
    border-right: 0px;
  }

  #mpris.paused {
    border-bottom: 2px solid @yellow;
  }

  #mpd {
    border-radius: 7px;
    margin-right: 5px;
    border-right: 0px;
  }

  #custom-pacman {
    color: #ff7a91;
    border-radius: 7px;
    margin-right: 5px;
  }

  #custom-pomodoro {
    color: #cdd6e1;
    border-radius: 7px;
    margin-right: 5px;
  }

  #custom-pomodoro.paused {
    border-bottom: 2px solid @yellow;
  }
''

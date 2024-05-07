{
  pkgs,
  lib,
  ...
}:
#with lib;
  #waybar-wttr = pkgs.stdenv.mkDerivation {
  #  name = "waybar-wttr";
  #  buildInputs = [
  #    (pkgs.python39.withPackages
  #      (pythonPackages= with pythonPackages; [requests]))
  #  ];
  #  unpackPhase = "true";
  #  installPhase = ''
  #    mkdir -p $out/bin
  #    cp ${./waybar-wttr.py} $out/bin/waybar-wttr
  #    chmod +x $out/bin/waybar-wttr
  #  '';
  #};
{
  #home.packages = [waybar-wttr];
  programs.waybar = {
    enable = true;
    style = import ./waybar-style.nix;
    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };
    settings = {
      mainbar = {
        layer = "top";
        position = "top";
        mod = "dock";
        #exclusive = true;
        passthrough = false;
        #gtk-layer-shell = true;
        height = 25;
        modules-left = [ 
          "network" 
          "cpu"
          "memory"
          "hyprland/workspaces"
        ];
        modules-center = [
          "mpris"
        ];
        modules-right = [
          "clock"
          "pulseaudio"
          "pulseaudio#microphone"
          "tray"
        ];

        "hyprland/window" = {
          format = "{}";
        };

        "hyprland/workspaces" = {
          disable-scroll = true;
          format = "{icon}";
          format-icons = {
            "1" = "1 "; 
            "2" = "2 "; 
            "3" = "3 ";
            "4" = "4 ";
            "5" = "5 "; 
            "6" = "6 "; 
            "7" = "7 ";
            "8" = "8 ";
            "9" = "9 ";
            "10"= "10 ";
          };
          on-click = "activate";
        };

        tray = {
          icon-size = 18;
          spacing = 10;
        };

        cpu = {
          interval = 1;
          format = "  {}%";
        };

        memory = {
          interval = 1;
          format = "  {}%";
        };


       clock = {
        format =  "  {:%H:%M }";
        format-alt = "  {:%a, %b %e }";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };


      backlight= {
        device= "intel_backlight";
        format= "{icon} {percent}%";
        format-icons= ["a" "b" "c"];
        on-scroll-up= "brightnessctl set 1%+";
        on-scroll-down= "brightnessctl set 1%-";
        min-length= 6;
      };

      battery= {
          states= {
              good= 95;
              warning= 30;
              critical= 20;
          };
          #
          format= "{icon} {capacity}%";
          format-charging= " {capacity}%";
          format-plugged= " {capacity}%";
          format-alt= "{time} {icon}";
          format-icons= ["1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11"];
      };

      pulseaudio= {
          format= "{icon} {volume}%";
          tooltip= false;
          format-muted= " Muted";
          on-click= "pamixer -t";
          on-right-click= "exec pavucontrol";
          on-scroll-up= "pamixer -i 5";
          on-scroll-down= "pamixer -d 5";
          scroll-step= 5;
          format-icons= {
              headphone= " ";
              hands-free= " ";
              headset= " ";
              phone= " ";
              portable= " ";
              car= " ";
              default= [" " " " " "];
          };
      };

      "pulseaudio#microphone"= {
          format= "{format_source}";
          format-source= "󰍮 {volume}%";
          format-source-muted= "󰍮 Muted";
          on-click= "pamixer --default-source -t";
          on-scroll-up= "pamixer --default-source -i 5";
          on-scroll-down= "pamixer --default-source -d 5";
          scroll-step= 5;
      };
      
      network= {
          # "interface"= "wlp2*", // (Optional) To force the use of this interface
          format-wifi= " {signalStrength}%";
          format-ethernet= "{cidr} 󰈁";
          tooltip-format= "{essid} - {ifname} via {gwaddr}";
          format-linked= "{ifname} (No IP) 󱞐 ";
          format-disconnected= "Disconnected 󰪎 ";
          format-alt= "{ifname}={essid} {ipaddr}/{cidr}";
      };

      bluetooth= {
        format= "bt {status}";
        format-disabled= ""; # an empty format will hide the module
        format-connected= "c {num_connections}";
        tooltip-format= "{device_alias}";
        tooltip-format-connected= "d {device_enumerate}";
        tooltip-format-enumerate-connected= "{device_alias}";
      };
      
      mpris= {
        title-len= 40;
        interval=1;
        album-len=0;
        max-len= 60;
        format= "{player_icon} {artist} - {title}";
        format-paused= "{player_icon} {artist} - {title}";
        player-icons= {
          default= "▶";
          mpv= "🎵";
          spotify= " ";
          firefox= "󰗃 ";
        };
        status-icons= {
          paused= "pause";
        };
        ignored-players= ["vlc"];
      };
      
      mpd= {
        format= "{stateIcon} {artist} - {title}";
        format-disconnected= "Disconnected dc";
        format-stopped= "{stateIcon} {artist} - {title}";
        interval= 2;
        consume-icons= {
          on= "c "; # Icon shows only when "consume" is on
        };
        "repeat-icons"= {
          on= "r ";
        };
        single-icons= {
          on= "s 1 ";
        };
        state-icons= {
          paused= "pause ";
          playing= "play ";
        };
        tooltip-format= "MPD (connected)";
        tooltip-format-disconnected= "MPD (disconnected)";
      };

      "custom/waybar-mpris"= {
    return-type= "json";
    exec= "waybar-mpris --position --autofocus";
    on-click= "waybar-mpris --send toggle";
    #// This option will switch between players on right click.
        on-click-right= "waybar-mpris --send player-next";
    #// The options below will switch the selected player on scroll
        #// "on-scroll-up": "waybar-mpris --send player-next",
        #// "on-scroll-down": "waybar-mpris --send player-prev",
    #// The options below will go to next/previous track on scroll
         "on-scroll-up"= "waybar-mpris --send next";
         "on-scroll-down"= "waybar-mpris --send prev";
    escape= true;
};

      "custom/pacman"= {
        format= "pac  {}";
        interval = 100;
        exec = "~/.local/scripts/checkupdate";
        exec-if = "exit 0";
        on-click= "alacritty -e paru";
      };
      
    "custom/pomodoro"= {
        exec= "i3-gnome-pomodoro status --format=waybar --show-seconds | awk '{gsub(/Pomodoro /,\"\")}1'";
        return-type= "json";
        interval= 1;
        format= "pomo {}";
        on-click= "i3-gnome-pomodoro toggle";
        on-middle-click= "i3-gnome-pomodoro stop";
        on-right-click= "i3-gnome-pomodoro start-stop";
      };
      };

    };
  };
}

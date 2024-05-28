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
  stylix.targets.waybar.enable = false;
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
          "group/boot"
          "network" 
          "cpu"
          "memory"
          "hyprland/workspaces"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "mpris"
          "pulseaudio"
          "tray"
        ];

        "hyprland/window" = {
          format = "{}";
        };

        "hyprland/workspaces" = {
          disable-scroll = true;
          format = "{icon}";
          format-icons = {
            "1" = "󰙯 "; 
            "2" = " "; 
            "3" = "󰧮";
            "4" = "󰊴";
            "5" = " ";
            "6" = " "; 
            "7" = "󰈹";
            "8" = "󰊠";
            "9" = "󰓓";
            "10" = "󰍹";
            #"1" = "一"; 
            #"2" = "二"; 
            #"3" = "三";
            #"4" = "四";
            #"5" = "五"; 
            #"6" = "六";
            #"7" = "七";
            #"8" = "八";
            #"9" = "九";
            #"10" = "十";
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
          #format =  "  {:%H:%M }";
          #format-alt = "  {:%a, %b %e }";
          #tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          format = "{:%a   %d %b   %H:%M}";
          calendar = {
            week-pos = "right";
            on-scroll = 1;
          };
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
            format-icons= [ " " " " " " " " " " ];
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
        
        network= {
            # "interface"= "wlp2*", // (Optional) To force the use of this interface
            format-wifi= "  {signalStrength}%";
            format-ethernet= "{cidr} 󰈁";
            tooltip-format= "{essid} - {ifname} via {gwaddr}";
            format-linked= "{ifname} (No IP) 󱞐 ";
            format-disconnected= "Disconnected 󰪎 ";
            format-alt= "{ifname}={essid} {ipaddr}/{cidr}";
        };

        bluetooth= {
          format= " {status}";
          format-disabled= ""; # an empty format will hide the module
          format-connected= " {num_connections}";
          tooltip-format= "{device_alias}";
          tooltip-format-connected= " {device_enumerate}";
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
            YoutubeMusic= "󰗃";
            spotify= "";
            firefox= "";
          };
          status-icons= {
            paused= "pause";
          };
          ignored-players= ["vlc" "firefox"];
        };

        "group/boot" = {
          orientation = "inherit";
          modules = [
            "custom/shutdown"
            "custom/reboot"
            "custom/logout"
          ];
          drawer = {
            transition-duration = 500;
          };
        };

        "custom/logout" = {
          format = "󰗽";
          tooltip = false;
          tooltip-format = "Exit Graphical Session";
          on-click = "hyprctl dispatch exit";
        };


        "custom/shutdown" = {
          format = " ";
          tooltip = false;
          tooltip-format = "Shutdown";
          on-click = "shutdown now";
        };

        "custom/reboot" = {
          format = "󰜉";
          tooltip = false;
          tooltip-format = "Reboot";
          on-click = "reboot";
        };
      };
    };
  };
}

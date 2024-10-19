# See dunst(5) for all configuration options
# not using this anymore, using mako instead
{
    pkgs,
    ...
} : {
    services.dunst = {
        enable = true;
        iconTheme = {
            name = "Tokyonight-Dark";
            package = pkgs.tokyo-night-gtk;
            size = "32x32";
        };
        settings = {
            global = {

            ### Display ###
            follow = "mouse";

            ### Geometry ###
            width = 300;
            height = 300;
            origin = "top-right";
            offset = "15x70";
            notification_limit = 8;

            ### Progress bar ###
            progress_bar = "true";
            progress_bar_height = 10;
            progress_bar_frame_width = 1;
            progress_bar_min_width = 150;
            progress_bar_max_width = 300;
            progress_bar_corner_radius = 5;
            icon_corner_radius = 5;
            indicate_hidden = "yes";
            padding = 8;
            horizontal_padding = 20;
            text_icon_padding = 0;
            frame_width = 2;
            frame_color = "#aaaaaa";
            gap_size = 1;
            #separator_color = "frame";
            sort = "yes";

            ### Text ###

            #font = "Iosevka Nerd Font 10";

            line_height = 3;
            markup = "full";
            format = "<b>%s</b>\n%b";
            alignment = "left";
            vertical_alignment = "center";
            show_age_threshold = 60;
            ellipsize = "middle";
            ignore_newline = "no";
            stack_duplicates = "true";
            hide_duplicate_count = "false";
            show_indicators = "yes";

            ### Icons ###
            enable_recursive_icon_lookup = "true";
            icon_position = "left";
            min_icon_size = 32;
            max_icon_size = 32 ;

            ### History ###

            sticky_history = "yes";

            history_length = 20;

            ### Misc/Advanced ###
            dmenu = "/usr/bin/dmenu -p dunst:";
            browser = "/usr/bin/xdg-open";
            always_run_script = "true";
            title = "Dunst";
            class = "Dunst";
            corner_radius = 10;
            ignore_dbusclose = "false";

            ### Wayland ###
            force_xwayland = "false";

            ### Legacy ###
            force_xinerama = "false";

            ### Mouse ###

            mouse_left_click = "close_current";
            mouse_middle_click = "do_action, close_current";
            mouse_right_click = "close_all";

            };

            experimental = {
                per_monitor_dpi = "false";
            };

            # TokyoNight colors for dunst
            # For more configuraion options see https://github.com/dunst-project/dunst/blob/master/dunstrc
            #urgency_low = {
            #    background = "#1e2030";
            #    foreground = "#c8d3f5";
            #    frame_color = "#c8d3f5";
            #};

            #urgency_normal = {
            #    background = "#222436";
            #    foreground = "#c8d3f5";
            #    frame_color = "#c8d3f5";
            #};

            #urgency_critical = {
            #    background = "#2f334d";
            #    foreground = "#c53b53";
            #    frame_color = "#c53b53";
            #};
        };
    };
}

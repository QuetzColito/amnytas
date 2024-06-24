{ lib, config, ... }: {
    # Requires libnotify
    services.mako = {
        enable = true;
        ### handled by stylix ###
        #backgroundColor = "#282828";
        backgroundColor =   lib.mkForce ("#" + builtins.substring 0 7 config.stylix.base16Scheme.base01 +"CC");
        #textColor = "#ebdbb2";
        #borderColor = "#32302f";
        #progressColor = "over #414559";
        #font = "DejaVu Sans 10";

        format = "<b>%s</b>\\n%b";
        height = 150;
        width = 400;
        margin = "10";
        padding = "10";

        borderRadius = 10;
        borderSize = 1;

        maxIconSize = 64;

        groupBy = "none";
        defaultTimeout = 10000;
        layer = "overlay";

        extraConfig = ''
            on-button-middle=dismiss-all
        '';

        # unused (for now)
        #actions = true;
        #anchor = "top-right";
        #incon-path = null;
        #icons = true;
        #ignoreTimeout = false;
        #maxVisible = 5;
        #output = null;
        #sort = "-time";


    };
}

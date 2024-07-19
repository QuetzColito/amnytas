{
  ...
} : {
    home.packages = [
    # this was an attempt at packaging dim-screen, but i have no idea how to package stuff
    #     pkgs.pkg-config
    # (pkgs.rustPlatform.buildRustPackage rec {
    #     pname = "dim-screen";
    #     version = "v0.2.2";
    #
    #     src = pkgs.fetchFromGitHub {
    #         owner = "marcelohdez";
    #         repo = "dim";
    #         rev = version;
    #         hash = "sha256:HIongNMK2+3j6lfvKDuqeIgFaC1yx6tDvkO3lloQWJE=";
    #     };
    #
    #     cargoHash = "sha256:LvHhIjqSu4/faVNF+S1X9LlmKKk938TsKdZYDyGL7kU=";
    #
    #     meta = {
    #         description = "";
    #         homepage = "https://github.com/marcelohdez/dim";
    #         license = lib.licenses.unlicense;
    #         maintainers = [];
    #   };})
    ];

    services.hypridle = {
        enable = true;
        settings = {
            general = {
                lock_cmd = ''loginctl lock-sessions'';
                unlock_cmd = ''loginctl unlock-sessions'';
                ignore_dbus_inhibit = false;
            };

            listener = [{
                timeout = 900;
                on-timeout = ''hyprctl dispatch dpms off'';
                on-resume = ''hyprctl dispatch dpms on'';
            }

            {
                timeout = 1020;
                on-timeout = ''hyprlock'';
            }

            {
                timeout = 3600;
                on-timeout = ''systemctl suspend'';
            }];
        };
    };
}

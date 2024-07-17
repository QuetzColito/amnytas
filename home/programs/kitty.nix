{
  lib,
  ...
} : {
    programs.kitty = {
        enable = true;
        shellIntegration.mode = "no-cursor";
        settings = {
            enable_audio_bell = false;
            cursor_blink_interval = 0;
            shell = "zsh";
        };
    };
}

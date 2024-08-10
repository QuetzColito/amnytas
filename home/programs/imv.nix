{
  config,
  ...
} : {
    programs.imv = {
        enable = true;
        settings.options = {
            background = config.stylix.base16Scheme.base00;
            overlay_font = "Inter:18";
            overlay_text_color = config.stylix.base16Scheme.base0E;
            overlay_text = "$imv_current_file $imv_width x $imv_height";
            overlay_background_color = config.stylix.base16Scheme.base02;
            overlay_background_alpha = "88";
        };
    };
}

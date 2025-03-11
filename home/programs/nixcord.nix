{
  inputs,
  pkgs-stable,
  ...
}: {
  imports = [
    inputs.nixcord.homeManagerModules.nixcord
  ];
  # dont think the options are very important
  programs.nixcord = {
    enable = true; # enable Nixcord. Also installs discord package
    discord.enable = false;
    vesktop.enable = true;
    # vesktop.package = pkgs-stable.vesktop;
    config = {
      enabledThemes = ["stylix.theme.css"];
      plugins = {
        alwaysAnimate.enable = true;
        alwaysTrust.enable = true;
        blurNSFW.enable = true;
        callTimer.enable = true;
        clearURLs.enable = true;
        crashHandler.enable = true;
        dearrow.enable = true;
        fixImagesQuality.enable = true;
        keepCurrentChannel.enable = true;
        roleColorEverywhere.enable = true;
        sendTimestamps.enable = true;
        unindent.enable = true;
        volumeBooster.enable = true;
        webKeybinds.enable = true;
        webRichPresence.enable = true;
        webScreenShareFixes.enable = true;
        youtubeAdblock.enable = true;
      };
    };
  };
}

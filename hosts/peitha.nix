{pkgs, ...}: {
  isNvidia = false;
  wantLimine = true;
  enableBluetooth = true;

  system.stateVersion = "25.05"; # Did you read the comment?

  hardware.i2c.enable = true;

  packages = with pkgs; [
    ddcutil
    (
      writeShellScriptBin "focus" ''
        hyprctl keyword monitor HDMI-A-7,disable
        hyprctl keyword monitor DP-5,disable
      ''
    )
  ];

  boot.loader.limine.extraEntries = ''
    /Windows
        protocol: efi
        path: uuid(e78adb91-b491-4dca-801f-c8ee2bd436e7):/EFI/Microsoft/Boot/bootmgfw.efi
  '';

  monitors = [
    {
      name = "DP-4";
      coords = "0x0";
      workspaces = [4 5 6];
    }
    {
      name = "HDMI-A-7";
      coords = "2560x660";
      workspaces = [7 8 9];
    }
    {
      name = "DP-5";
      coords = "-1080x50";
      rotation = "1";
      workspaces = [1 2 3];
    }
    {
      name = "DP-1";
      coords = "0x0";
      workspaces = [4 5 6];
    }
    {
      name = "HDMI-A-2";
      coords = "2560x660";
      workspaces = [7 8 9];
    }
    {
      name = "DP-2";
      coords = "-1080x50";
      rotation = "1";
      workspaces = [1 2 3];
    }
  ];
}

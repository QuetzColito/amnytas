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
}

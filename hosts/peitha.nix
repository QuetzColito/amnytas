{pkgs, ...}: {
  isNvidia = false;
  wantGrub = true;

  system.stateVersion = "25.05"; # Did you read the comment?

  packages = [
    (pkgs.writeShellScriptBin "Gw2" ''bottles-cli run -b Gw2 --executable "/home/quetz/My Games/bottles/Gw2/drive_c/Program Files/Guild Wars 2/Gw2-64.exe"'')
  ];

  autostartApps = true;

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
  ];
}

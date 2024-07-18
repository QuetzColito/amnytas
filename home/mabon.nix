{
  lib,
  pkgs,
  ...
} : {
    home = {
        username = "arthezia";
        homeDirectory = "/home/arthezia";
        stateVersion = "23.11"; # Please read the comment before changing.
        packages = with pkgs; [
            (writeShellScriptBin "nvidia-offload" ''
                export __NV_PRIME_RENDER_OFFLOAD=1
                export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
                export __GLX_VENDOR_LIBRARY_NAME=nvidia
                export __VK_LAYER_NV_optimus=NVIDIA_only
                exec "$@"
            '')
        ];
    };

    imports = [
        ./home.nix
    ];

    monitors = [
        {
            id = "eDP-1";
            wallpaper = "~/nixos/wallpaper/side.jpg";
            coords = "0x0";
            workspaces = [ 1 2 3 7 8 9];
        }
        {
            id = "HDMI-A-1";
            wallpaper = "~/nixos/wallpaper/main.jpg";
            coords = "-1920x0";
            workspaces = [ 4 5 6 ];
        }
    ];

    programs.waybar.settings.mainbar.modules-right = ["battery"];

    wayland.windowManager.hyprland.settings = {
        input.sensitivity = lib.mkForce 1;
    };
    programs.vscode.userSettings."workbench.colorTheme"= lib.mkForce "Tokyo Night Storm";
}

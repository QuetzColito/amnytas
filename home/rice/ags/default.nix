{ inputs, pkgs, ... }:
let
    ags = "ags -c ~/nixos/home/rice/ags/config.js";
in
{
    # add the home manager module
    imports = [ inputs.ags.homeManagerModules.default ];
    home.shellAliases.AGS = ags;
    home.packages = [
        pkgs.sassc
        (pkgs.writeShellScriptBin
            "togglecurrentbar"
            ''
            ${ags} --toggle-window bar$(hyprctl activeworkspace -j | jq '.monitorID')
            ''
        )
    ];

    programs.ags = {
        enable = true;

        # additional packages to add to gjs's runtime
        extraPackages = with pkgs; [
            gtksourceview
            webkitgtk
            accountsservice
        ];
    };
}

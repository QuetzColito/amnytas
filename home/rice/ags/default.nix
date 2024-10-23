{
  inputs,
  pkgs,
  ...
}: let
  ags = "ags -c ~/amnytas/home/rice/ags/config.js";
in {
  # add the home manager module
  imports = [inputs.ags.homeManagerModules.default];
  home.shellAliases.AGS = ags;
  home.packages = [
    pkgs.sassc
    (pkgs.writeShellScriptBin "reloadags" "${ags} -q; ${ags}")
    (
      pkgs.writeShellScriptBin
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
      # changed this from the snippet i got from the website because home-manger complained
      # but seems to work
      webkitgtk_6_0
      accountsservice
    ];
  };
}

{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    tuiPackages = lib.mkOption {
      default = [];
      type = lib.types.listOf lib.types.package;
    };
  };

  config = {
    # simple, yet very useful imo
    xdg.configFile."tofi/config".text = ''
      width = 100%
      height = 100%
      border-width = 0
      outline-width = 0
      padding-left = 35%
      padding-top = 35%
      result-spacing = 25
      num-results = 15
      font = monospace
      background-color = #0005
      selection-color = #7AA2F7
    '';
    home.packages = with pkgs; [
      tofi
      (writeShellScriptBin
        "my-tofi-run"
        "filter-tofi $(tofi-run --ascii-input true)")
      (writers.writeRustBin "filter-tofi" {} ''
        use std::env;
        fn main() {
            let arg = &env::args().last().unwrap();
            let tuis = vec![${builtins.concatStringsSep "," (map (p: "\"" + (builtins.toString (lib.meta.getExe p)) + "\"") config.tuiPackages)}];
            println!(
                "{}{}",
                if tuis.into_iter().any(|tui| tui.ends_with(arg)) {
                    "foot "
                } else {
                    ""
                },
                arg
            );
        }
      '')
    ];
  };
}

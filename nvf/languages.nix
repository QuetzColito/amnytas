_: {
  # global opts
  enableExtraDiagnostics = true;
  enableFormat = true;
  enableTreesitter = true;

  # Languages
  nix.enable = true;
  rust.enable = true;
  ts.enable = true;
  python.enable = true;
  java.enable = true;
  typst = {
    enable = true;
    format.enable = false;
  };
}

{
  hh,
  config,
  ...
}: {
  files.".config/hypr/monitors.conf".text =
    hh.mkList "monitor"
    [
      # ",highrr,auto,1"
      "Unknown-1,disable"
    ]
    ++ map (
      {
        name,
        coords,
        rotation ? "",
        ...
      } @ monitor:
        monitor.config
        or (name
          + ",preferred,"
          + coords
          + ",1"
          + (
            if rotation == ""
            then ""
            else ",transform," + rotation
          ))
    )
    config.monitors;
}

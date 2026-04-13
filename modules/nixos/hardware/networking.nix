{
  lib,
  opts,
  ...
}:
let
  cfg = opts.hardware.networking or { };
in
{
  networking = cfg;
}

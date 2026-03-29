{
  lib,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.hardware.network or { };
in
{
  networking = cfg;
}

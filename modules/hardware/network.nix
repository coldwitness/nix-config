{
  lib,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.hardware.network;
in
{
  networking = cfg;
}

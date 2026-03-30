{
  lib,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.hardware.networking or { };
in
{
  networking = cfg;
}

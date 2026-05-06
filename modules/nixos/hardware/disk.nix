{
  opts,
  inputs,
  ...
}:
let
  cfg = opts.hardware.disk or { };
in
{
  imports = [
    inputs.disko.nixosModules.disko
  ];
  disko.devices.disk = cfg;
}

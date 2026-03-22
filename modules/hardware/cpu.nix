{
  lib,
  config,
  hostConfig,
  ...
}:
let
  cfg = hostConfig.hardware.cpu;
in
{
  config = lib.mkMerge [
    (lib.mkIf (cfg.type == "amd") {
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    })
    (lib.mkIf (cfg.type == "intel") {
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    })
  ];
}

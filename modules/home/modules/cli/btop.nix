{
  lib,
  pkgs,
  opts,
  ...
}:
let
  cfg = opts.cli.btop or { };
  finallyEnable = cfg.enable or false;
  gpuType = opts.hardware.graphics.type or "";
in
{
  config = lib.mkIf finallyEnable {
    programs.btop = {
      enable = true;
    } // lib.optionalAttrs (gpuType == "amd") {
      package = pkgs.btop-rocm;
    };
  };
}

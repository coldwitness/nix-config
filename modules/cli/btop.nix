{
  lib,
  pkgs,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.cli.btop;
  finallyEnable = cfg.enable;
in
{
  config = lib.mkIf finallyEnable {
    environment.systemPackages = with pkgs; [
      
    ]
    ++ lib.optionals (cfg.type == "") [
      btop
    ] ++ lib.optionals (cfg.type == "amd") [
      btop-rocm
    ];
  };
}

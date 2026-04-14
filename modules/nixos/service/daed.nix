{
  lib,
  pkgs,
  opts,
  inputs,
  ...
}:
let
  cfg = opts.service.daed or { };
  finallyEnable = cfg.enable or false;
in
{
  imports = [
    inputs.daeuniverse.nixosModules.daed
  ];
  config = lib.mkIf finallyEnable {
    services.daed = {
      enable = true;
      package = inputs.daeuniverse.packages.${pkgs.stdenv.hostPlatform.system}.daed;
      openFirewall = {
        enable = true;
        port = 12345;
      };
      configDir = "/etc/daed";
      listen = "127.0.0.1:2023";
    };
  };
}

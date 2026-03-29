{
  lib,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.service.rustdesk-server or { };
  finallyEnable = cfg.enable or false;
  relayHosts = cfg.relayHosts or [ ];
in
{
  config = lib.mkIf finallyEnable {
    services.rustdesk-server = {
      enable = true;
      openFirewall = true;
      signal = {
        enable = true;
        inherit relayHosts;
      };
      relay.enable = true;
    };
  };
}

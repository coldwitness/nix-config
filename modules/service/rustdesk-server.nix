{
  lib,
  inputs,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.service.rustdesk-server or { };
  finallyEnable = cfg.enable or false;
  settingsFile = "${inputs.secrets}/rustdesk-server/${hostOptions.hardware.networking.hostName}.nix";
  settings = if builtins.pathExists settingsFile 
             then import settingsFile
             else { };
  relayHosts = settings.relayHosts or [ ];
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

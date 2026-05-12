{
  lib,
  pkgs,
  opts,
  config,
  inputs,
  ...
}:
let
  cfg = opts.service.openlist or { };
  finallyEnable = cfg.enable or false;
in
{
  imports = [
    inputs.nur-moraxyc.nixosModules.alist
  ];
  config = lib.mkIf finallyEnable {
    sops.secrets."alist/jwt_secret" = {
      sopsFile = ../../../secrets/alist.yaml;
      format = "yaml";
      owner = "alist";
      group = "alist";
      mode = "0400";
    };
    sops.templates."alist-jwt_secret" = {
      content = ''
        ${config.sops.placeholder."alist/jwt_secret"}
      '';
      owner = "alist";
      group = "alist";
      mode = "0400";
    };
    services.alist = {
      enable = true;
      package = pkgs.openlist;
      settings.jwt_secret._secret = config.sops.templates."alist-jwt_secret".path;
    };
  };
}

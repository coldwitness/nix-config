{
  lib,
  pkgs,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.internet.rustdesk or { };
  finallyEnable = cfg.enable or false && ((hostOptions.desktop.type or "") != "");
in
{
  config = lib.mkIf finallyEnable {
    home.packages = with pkgs; [
      # 新版客户端
      rustdesk-flutter
      # 如果您需要旧版客户端(不推荐)
      # rustdesk
    ];
  };
}

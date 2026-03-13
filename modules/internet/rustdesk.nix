{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    # 新版客户端
    rustdesk-flutter
    # 如果您需要旧版客户端(不推荐)
    # rustdesk
  ];
}

{
  config,
  ...
}:
{
  imports = [ ../../../modules/home/modules ];
  # 用户配置
  home = {
    # 用户名
    username = "mint";
    # 用户 home 目录
    homeDirectory = "/home/mint";
    # 状态版本
    stateVersion = "26.05";
  };
}

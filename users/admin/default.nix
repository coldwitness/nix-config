{
  config,
  ...
}:
{
  # 导入其他模块
  imports = [
    ./modules
    ];
  # 注入到所有子模块的参数
  _module.args = {
    configPath = "${config.home.homeDirectory}/workspace/nix-config/users/admin/config";
  };
  # 用户配置
  home = {
    # 用户名
    username = "admin";
    # 用户 home 目录
    homeDirectory = "/home/admin";
    # 状态版本
    stateVersion = "26.05";
  };
}

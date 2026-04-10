{
  lib,
  config,
  ...
}:
let
  username = lib.baseNameOf (toString ./.);
in
{
  imports = [ ../../../modules/home/modules ];
  # 用户配置
  home = {
    # 用户名
    inherit username;
    # 用户 home 目录
    homeDirectory = "/home/${username}";
    # 状态版本
    stateVersion = "26.05";
  };
}

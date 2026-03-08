{
  config,
  lib,
  pkgs,
  ...
}:
{
  # 导入其他模块
  imports = [
    ./tool/index.nix        # 工具模块
    ];
}

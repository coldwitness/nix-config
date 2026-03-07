{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    # 导入其他模块
    ./tool/index.nix        # 工具模块
    ./shell/index.nix       # 命令行模块
    ./media/index.nix       # 多媒体模块
    ./i18n/chinese.nix      # 本地化模块
    ./editor/index.nix      # 编辑器模块
    ./internet/index.nix    # 网络工具模块
    ./desktop/index.nix     # 桌面模块
    ];
}

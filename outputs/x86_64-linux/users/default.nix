{
  lib,
  inputs,
  pkgSets,
  hostOptions ? null,
  ...
}:
let
  cfg = hostOptions.users or { };
  isStandAlone = hostOptions == null;
in
{
  imports = lib.optionals (!isStandAlone) [ inputs.home-manager.nixosModules.home-manager ];
  config = lib.mkMerge [
    # 独立模式
    (lib.mkIf isStandAlone {
      # TODO: 待实现
    })
    # 非独立模式
    (lib.mkIf (!isStandAlone) {
      users = {
        # 设置 false 开启完全声明式管理
        mutableUsers = false;
        # 用户配置
        users = cfg;
      };
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        # 动态导入用户配置
        users = builtins.foldl' (acc: userName:
          if userName == "root" then acc
          else acc // { ${userName} = import ./${userName}; }
        ) {} (builtins.attrNames (cfg // {}));
        # 传递给子模块的参数
        extraSpecialArgs = {
          inherit inputs pkgSets hostOptions;
        };
      };
    })
  ];
}

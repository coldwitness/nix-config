{
  inputs,
  pkgSets,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.users;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
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
}

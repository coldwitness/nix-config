{
  lib,
  inputs,
  pkgSets,
  hostOptions ? null,
  ...
}:
let
  isStandAlone = hostOptions == null;
  cfg = hostOptions.users or { };
  # 读取当前目录下的所有文件和目录
  entries = builtins.readDir ./.;
  # 筛选出所有用户目录
  userDirs = builtins.filter (name:
    let
      # 获取当前条目 n 的类型 (directory/regular/symlink)
      entry = entries.${name};
    in
    # 是 directory
    entry == "directory"
    # 不是 root
    && name != "root"
    # 存在 default.nix
    && builtins.pathExists ./${name}/default.nix
    # 存在 hostOptions.nix
    && builtins.pathExists ./${name}/hostOptions.nix
  ) (builtins.attrNames entries);
  # 定义导入用户配置函数
  importUser = name:
    let
      # 加载用户 hostOptions
      userHostOptions = import ./${name}/hostOptions.nix { inherit inputs; };
      # 构建 HM 配置
      hmCfg = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = pkgSets.pkgs;
        modules = [ (import ./${name}) ];
        extraSpecialArgs = {
          inherit inputs pkgSets;
          hostOptions = userHostOptions;
        };
      };
    in { ${name} = hmCfg; };
  # 对所有用户目录应用 importUser 函数
  homeConfigurations = builtins.foldl' (acc: userCfg: acc // userCfg) { } (
    builtins.map importUser userDirs
  );
in
# 独立模式: 返回纯 attrset, 供 outputs/default.nix 直接使用
if isStandAlone then { inherit homeConfigurations; }
# 非独立模式: 返回 NixOS module, 供主机配置导入
else
  {
    imports = [ inputs.home-manager.nixosModules.home-manager ];
    config = {
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
    };
  }

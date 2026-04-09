inputs:
let
  inherit (inputs.nixpkgs) lib;
  inherit (import ../vars { inherit inputs; }) systemTypes;
  # 定义所有可用的 pkgs 实例
  pkgSets = system: with inputs; {
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
    pkgs-2511 = import nixpkgs-2511 {
      inherit system;
      config.allowUnfree = true;
    };
  };
  # 读取 hosts 目录下的所有文件和目录
  entries = builtins.readDir ./hosts;
  # 筛选出所有架构目录
  platformDirs = builtins.filter (n:
    let
      type = entries.${n};
    in
    # 是 directory
    type == "directory"
    # 存在 default.nix
    && builtins.pathExists (./hosts + "/${n}/default.nix")
  ) (builtins.attrNames entries);
  # 定义导入架构配置函数
  importPlatform = name: {
    # 加载该架构的主机配置
    hosts = import ./hosts/${name} {
      inherit lib inputs;
      system = systemTypes.${name};
      pkgSets = pkgSets systemTypes.${name};
    };
    # 加载用户配置
    users = import ./users {
      inherit lib inputs;
      pkgSets = pkgSets systemTypes.${name};
    };
  };
  # 对所有架构目录应用 importPlatform 函数
  platforms = builtins.map importPlatform platformDirs;
  # 合并所有架构的输出
  allNixosConfigurations = lib.attrsets.mergeAttrsList (
    builtins.map (a: a.hosts.nixosConfigurations) platforms
  );
  allHomeConfigurations = lib.attrsets.mergeAttrsList (
    builtins.map (a: a.users.homeConfigurations) platforms
  );
  # 为每个架构的用户创建独立的顶层输出, 便于 nh 直接引用
  # 使用方式: nh home switch .#<username>-<platform>
  homeManagerOutputs = builtins.listToAttrs (
    lib.flatten (
      builtins.map (platform:
        let
          platformConfigs = (import ./users {
            inherit lib inputs;
            pkgSets = pkgSets systemTypes.${platform};
          }).homeConfigurations;
        in
        builtins.map (username: {
          name = "${username}-${platform}";
          value = platformConfigs.${username}.activationPackage;
        }) (builtins.attrNames platformConfigs)
      ) platformDirs
    )
  );
in
{
  nixosConfigurations = allNixosConfigurations;
  homeConfigurations = allHomeConfigurations;
} // homeManagerOutputs

inputs:
let
  inherit (inputs.nixpkgs) lib;
  inherit (import ../vars) systemTypes;
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
  # 读取当前目录下的所有文件和目录
  entries = builtins.readDir ./.;
  # 筛选出所有架构目录
  platformDirs = builtins.filter (n:
    let
      type = entries.${n};
    in
    # 是 directory
    type == "directory"
    # 存在 default.nix
    && builtins.pathExists (./. + "/${n}/default.nix")
  ) (builtins.attrNames entries);
  # 定义导入架构配置函数
  importPlatform = name: import (./. + "/${name}") {
    system = systemTypes.${name};
    inherit lib inputs;
    pkgSets = pkgSets systemTypes.${name};
  };
  # 对所有架构目录应用 importPlatform 函数
  platforms = builtins.map importPlatform platformDirs;
  # 合并所有架构的输出
  allNixosConfigurations = lib.attrsets.mergeAttrsList (
    builtins.map (a: a.nixosConfigurations) platforms
  );
  allHomeConfigurations = lib.attrsets.mergeAttrsList (
    builtins.map (a: a.homeConfigurations) platforms
  );
in
{
  nixosConfigurations = allNixosConfigurations;
  homeConfigurations = allHomeConfigurations;
}

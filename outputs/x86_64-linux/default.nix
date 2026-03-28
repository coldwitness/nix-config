{
  lib,
  inputs,
  system,
  pkgSets,
  ...
}:
let
  # 读取当前目录下的所有文件和目录
  entries = builtins.readDir ./.;
  # 筛选出所有主机目录
  hostDirs = builtins.filter (n:
    let
      # 获取当前条目 n 的类型 (directory/regular/symlink)
      type = entries.${n};
    in
    # 同时满足: 是 directory 并且不是 tests 并且存在 default.nix
    type == "directory" && n != "tests" && builtins.pathExists (./. + "/${n}/default.nix")
  ) (builtins.attrNames entries);
  # 定义导入函数, 用于加载单个主机配置
  importHost = name: import (./. + "/${name}") {
    inherit lib inputs system pkgSets;
  };
  # 对所有主机目录应用 importHost 函数
  hosts = builtins.map importHost hostDirs;
  # 合并所有主机的 nixosConfigurations
  allNixosConfigurations = lib.attrsets.mergeAttrsList (
    # 先用 builtins.map 提取每个主机的 nixosConfigurations
    builtins.map (h: h.nixosConfigurations) hosts
  );
in
{
  # 导出一个合并后的 nixosConfigurations, 包含所有主机配置
  nixosConfigurations = allNixosConfigurations;
}

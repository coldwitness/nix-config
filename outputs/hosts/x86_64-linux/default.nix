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
    # 是 directory
    type == "directory"
    # 存在 default.nix
    && builtins.pathExists (./. + "/${n}/default.nix")
  ) (builtins.attrNames entries);
  # 定义导入主机配置函数
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

{
  lib,
  vars,
  optSets,
  functions,
  ...
}:
let
  # 读取目录内容(返回 { 文件名: 类型; } 的属性集)
  content = builtins.readDir ./.;
  # 筛选出所有符合要求的主机目录
  userDirs = builtins.attrNames (
    lib.filterAttrs (
      name: type:
      # 是目录(directory)
      type == "directory"
      # 存在 opts.nix
      && builtins.pathExists (./. + "/${name}/opts.nix")
    ) content
  );
  # 使用 mkHome 批量生成 homeConfigurations
  homeConfigurations = lib.foldl' (
    acc: dir:
    let
      opts = import (./. + "/${dir}/opts.nix") {
        inherit vars optSets;
        hostName = dir;
      };
    in
    acc // (functions.mkHome opts dir vars)
  ) { } userDirs;
in
homeConfigurations

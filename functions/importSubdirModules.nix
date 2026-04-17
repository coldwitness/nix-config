/*
  功能:
    导入指定目录下所有子目录中的 .nix 模块
  输入参数:
    dir: 目标目录路径, 将扫描该目录下所有子目录符合条件的 .nix 文件
  返回值:
    所有子目录中 .nix 文件导入结果的列表
*/
{
  inputs,
  ...
}:
# dir: 目标父目录路径, 将扫描其下一级子目录
dir:
let
  inherit (inputs.nixpkgs) lib;
  # 获取指定目录下所有 .nix 文件的完整路径列表
  # d: 要扫描的目录路径
  getNixFiles =
    d:
    let
      # 读取目录内容(返回 { 文件名: 类型; } 的属性集)
      content = builtins.readDir d;
      # 过滤出普通文件类型并且为 .nix 后缀的文件名列表
      nixFiles = builtins.attrNames (
        lib.filterAttrs (name: type: type == "regular" && lib.hasSuffix ".nix" name) content
      );
    in
    # 将文件名拼接为完整路径(d + "/" + 文件名)
    builtins.map (file: d + "/${file}") nixFiles;
  # 获取 dir 下所有一级子目录的名称列表
  subdirs = builtins.attrNames (
    lib.filterAttrs (name: type: type == "directory") (builtins.readDir dir)
  );
  # 遍历每个子目录, 收集其中所有 .nix 文件的路径, 合并为扁平列表
  allModulePaths = builtins.concatMap (subdir: getNixFiles (dir + "/${subdir}")) subdirs;
in
# 逐个 import 所有模块文件, 返回导入结果列表
builtins.map (path: import path) allModulePaths

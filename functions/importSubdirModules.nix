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
dir:
let
  inherit (inputs.nixpkgs) lib;
  # 定义获取目录 nix 文件的函数
  getNixFiles =
    /*
      功能:
        获取指定目录下所有 .nix 文件的完整路径列表
      输入参数:
        subdir: 要扫描的子目录
      返回值:
        一个包含指定子目录下所有 .nix 文件完整路径的列表
    */
    subdir:
    let
      # 读取目录内容(返回 { 文件名: 类型; } 的属性集)
      content = builtins.readDir subdir;
      # 筛选出所有符合要求的文件
      nixFiles = builtins.attrNames (
        lib.filterAttrs (
          name: type:
          # 是文件(regular)
          type == "regular"
          # 后缀为 .nix
          && lib.hasSuffix ".nix" name
        ) content
      );
    in
    # 将文件名拼接为完整路径(subdir + "/" + 文件名)
    builtins.map (file: subdir + "/${file}") nixFiles;
  # 获取 dir 下所有一级子目录的名称列表
  subdirs = builtins.attrNames (
    lib.filterAttrs (name: type: type == "directory") (builtins.readDir dir)
  );
  # 遍历每个子目录, 收集其中所有 .nix 文件的路径, 合并为扁平列表
  allModulePaths = builtins.concatMap (subdir: getNixFiles (dir + "/${subdir}")) subdirs;
  # 逐个 import 所有模块文件, 返回导入结果列表
  importSubdirModules = builtins.map (path: import path) allModulePaths;
in
importSubdirModules

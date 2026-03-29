{
  lib,
  ...
}:
dir:
let
  # 获取目录下所有 .nix 文件的路径列表
  getNixFiles = d:
    let
      content = builtins.readDir d;
      nixFiles = builtins.attrNames (
        lib.filterAttrs (name: type: type == "regular" && lib.hasSuffix ".nix" name) content
      );
    in builtins.map (file: d + "/${file}") nixFiles;
  # 获取所有子目录名称
  subdirs = builtins.attrNames (
    lib.filterAttrs (name: type: type == "directory") (builtins.readDir dir)
  );
  # 收集所有子目录中的 .nix 文件路径
  allModulePaths = builtins.concatMap (subdir: getNixFiles (dir + "/${subdir}")) subdirs;
in
# 导入所有模块
builtins.map (path: import path) allModulePaths

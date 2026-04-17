/*
  功能:
    导入指定目录下的 .nix 文件, 将其转换为属性集
  输入参数:
    dir: 目标目录路径, 将扫描该目录下所有符合条件的 .nix 文件
  返回值:
    以文件名去掉 .nix 后缀为 key, 文件导入结果为 value 的属性集
*/
{
  inputs,
  ...
}:
dir:
let
  inherit (inputs.nixpkgs) lib;
  # 读取目录内容(返回 { 文件名: 类型; } 的属性集)
  content = builtins.readDir dir;
  # 筛选出所有符合要求的文件
  nixFiles = builtins.attrNames (
    lib.filterAttrs (
      name: type:
      # 是文件(regular)
      type == "regular"
      # 后缀为 .nix
      && lib.hasSuffix ".nix" name
      # 非 default.nix
      && name != "default.nix"
    ) content
  );
  # 去掉每个文件名的 .nix 后缀, 作为属性集的 key
  fileNames = builtins.map (file: lib.removeSuffix ".nix" file) nixFiles;
  # 将文件名列表转换为属性集, 每个元素导入对应的 .nix 文件
  importFilesForAttrs = builtins.listToAttrs (
    lib.imap0 (i: name: {
      inherit name;
      # 根据索引 i 从 nixFiles 中取回原始文件名, 拼接完整路径并 import
      value = import (dir + "/${builtins.elemAt nixFiles i}") { inherit inputs; };
    }) fileNames
  );
in
importFilesForAttrs

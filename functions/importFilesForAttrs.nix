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
  # 读取目录内容, 获取文件列表
  content = builtins.readDir dir;
  # 过滤出普通文件类型并且为 .nix 后缀并且非 default.nix 的文件名列表
  nixFiles = builtins.attrNames (
    lib.filterAttrs (
      name: type: type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix"
    ) content
  );
  # 去掉每个文件名的 .nix 后缀, 作为属性集的 key
  fileNames = builtins.map (file: lib.removeSuffix ".nix" file) nixFiles;
in
# 将文件名列表转换为属性集, 每个元素导入对应的 .nix 文件
builtins.listToAttrs (
  lib.imap0 (i: name: {
    inherit name;
    # 根据索引 i 从 nixFiles 中取回原始文件名, 拼接完整路径并 import
    value = import (dir + "/${builtins.elemAt nixFiles i}") { inherit inputs; };
  }) fileNames
)

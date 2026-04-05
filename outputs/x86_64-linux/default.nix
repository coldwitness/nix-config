{
  lib,
  inputs,
  system,
  pkgSets,
  ...
}:
let
  # 加载该架构下的所有主机配置
  hosts = import ./hosts { inherit lib inputs system pkgSets; };
  # 加载该架构下的所有用户配置
  users = import ./users { inherit lib inputs pkgSets; };
in
{
  # 合并该架构下的所有 NixOS 主机配置
  inherit (hosts) nixosConfigurations;
  # 该架构下的 Home Manager 独立构建输出
  inherit (users) homeConfigurations;
}

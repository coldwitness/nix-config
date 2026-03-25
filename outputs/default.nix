inputs:
let
  lib = inputs.nixpkgs.lib;

  # 加载 x86_64-linux 系统配置
  x86_64-linux = import ./x86_64-linux {
    inherit lib inputs;
  };
in
{
  # 合并所有 nixosConfigurations
  nixosConfigurations = lib.attrsets.mergeAttrsList [
    x86_64-linux.nixosConfigurations
  ];

  # 导出 hostConfig
  hostConfig = x86_64-linux.hostConfig;
}

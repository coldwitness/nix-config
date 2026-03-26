{
  lib,
  inputs,
  ...
}:
let
  system = "x86_64-linux";

  # 主分支的 nixpkgs 实例
  pkgs = inputs.nixpkgs.legacyPackages.${system};
  # 预构建 unstable 包集
  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit system;
  };

  # 加载 FL8850UA 主机配置
  hostArgs = {
    inherit inputs lib pkgs-unstable;
  };
  FL8850UA = import ./FL8850UA hostArgs;
in
{
  # 导出 hostConfig 供模块使用
  hostConfig = FL8850UA.hostConfig // {
    inherit system;
  };

  # 导出 nixosConfigurations
  nixosConfigurations = FL8850UA.nixosConfigurations;
}

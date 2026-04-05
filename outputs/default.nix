inputs:
let
  inherit (inputs.nixpkgs) lib;
  inherit (import ../vars) systemTypes;
  # 定义所有可用的 pkgs 实例
  pkgSets = system: with inputs; {
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
    pkgs-2511 = import nixpkgs-2511 {
      inherit system;
      config.allowUnfree = true;
    };
  };
  # 加载 x86_64-linux 系统配置
  x86_64-linux = import ./x86_64-linux/hosts {
    system = systemTypes.x86_64-linux;
    inherit lib inputs;
    pkgSets = pkgSets systemTypes.x86_64-linux;
  };
in
{
  # 合并所有 nixosConfigurations
  nixosConfigurations = lib.attrsets.mergeAttrsList [
    x86_64-linux.nixosConfigurations
  ];
}

{
  lib,
  inputs,
  system,
  pkgSets,
  ...
}:
let
  # 生成的实例数量, <=1 则不批量生成, >1 表示批量生成
  count = 1;
  # 从当前目录路径提取基础主机名
  baseHostName = lib.baseNameOf (toString ./.);
  hostNames =
    if
      count <= 1
    # 单机模式: 返回 [baseHostName]
    then
      [ baseHostName ]
    # 批量模式: 生成 ${baseHostName}-1 ~ ${baseHostName}-N 格式的列表
    else
      builtins.genList (i: "${baseHostName}-${builtins.toString (i + 1)}") count;
  # 构建单个主机的 NixOS 配置, 参数 hostName 用于区分不同实例
  buildHost =
    hostName:
    let
      # 每个实例独立加载选项配置(传入各自的主机名)
      opts = import ./opts.nix { inherit inputs hostName; };
    in
    {
      ${hostName} = lib.nixosSystem {
        inherit system;
        pkgs = pkgSets.pkgs;
        specialArgs = {
          inherit inputs opts pkgSets;
        };
        modules = [
          ../../../home
          ../../../../modules/nixos
          ./hardware-configuration.nix
          { system.stateVersion = "25.11"; }
        ];
      };
    };
in
{
  # 将所有实例的 nixosConfigurations 合并为一个 attrset
  nixosConfigurations = builtins.listToAttrs (
    builtins.map (hn: {
      name = hn;
      value = (buildHost hn).${hn};
    }) hostNames
  );
}

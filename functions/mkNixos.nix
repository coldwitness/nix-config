/*
  功能:
    生成一个或多个 nixosConfigurations(根据 opts.host.count 决定实例数量)
  输入参数:
    opts: 原始选项属性集(必须包含 host.count 和 host.system 等)
    baseName: 基础主机名(用作实例名称前缀)
  返回值:
    { "基础名称" = ...; } 或 { "基础名称-1" = ...; "基础名称-2" = ...; ... }
*/
{
  inputs,
  ...
}:
let
  inherit (inputs.nixpkgs) lib;
  # 导入辅助函数
  generateCountNames = import ./generateCountNames.nix { inherit inputs; };
  buildPkgSets = import ./buildPkgSets.nix { inherit inputs; };
  deepMergeAttrs = import ./deepMergeAttrs.nix { inherit inputs; };
  mergeAttrsList = import ./mergeAttrsList.nix { inherit inputs; };
  mkNixos =
    opts: baseName:
    let
      # 从 opts 获取信息
      inherit (opts.host) count system stateVersion;
      pkgSets = buildPkgSets system;
      hostCustomOptSets = opts.host.customOptSets or [ ];
      hostPredefinedOptSetsList = opts.host.predefinedOptSetsList or [ ];
      nixosOpts = deepMergeAttrs (mergeAttrsList hostPredefinedOptSetsList) hostCustomOptSets;
      # 提取所有用户的 base 配置(即 users)
      users = lib.mapAttrs (_: user: user.base or { }) opts.users or { };
      # 根据 count 生成主机名称列表
      hostNames = generateCountNames baseName count;
      # 定义生成单个 nixosConfigurations 的函数
      mkSingleNixos =
        hostName:
        let
          # 深度合并特定的 hostName 到原有 nixosOpts 中
          nixosOpts' = deepMergeAttrs nixosOpts { hardware.networking.hostName = hostName; };
        in
        {
          ${hostName} = lib.nixosSystem {
            inherit system;
            pkgs = pkgSets.pkgs;
            # 传给子模块的参数
            specialArgs = {
              inherit inputs pkgSets;
              opts = nixosOpts';
            };
            modules = [
              # nixos 模块
              ../modules/nixos
              # 自动生成的硬件配置
              (../outputs/nixos + "/${baseName}/hardware-configuration.nix")
              # Home Manager 模块
              inputs.home-manager.nixosModules.home-manager
              {
                # 初始状态版本
                system.stateVersion = stateVersion;
                users = {
                  # 设置 false 开启完全声明式管理
                  mutableUsers = false;
                  # 用户配置
                  inherit users;
                };
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                };
              }
            ];
          };
        };
    in
    # 将所有实例配置合并为一个属性集
    lib.foldl' (acc: name: acc // (mkSingleNixos name)) { } hostNames;
in
mkNixos

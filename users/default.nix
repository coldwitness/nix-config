{
  inputs,
  hostConfig,
  pkgs-unstable,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
  users = {
    # 开启完全声明式管理
    mutableUsers = false;
    # 用户配置
    users = {
      root = {
        # 哈希密码
        hashedPassword = "$6$yk.jU.kxIAVwaoaj$zFEdwFofY8P88Ad7/a62sm5j3QxyXcQxKTvTpRMIYDgw6G4RDXZCQgHRyeOyZHLN10lKov55WJESL8t2Ia1US0";
      };
      admin = {
        # 普通用户
        isNormalUser = true;
        # 用户描述
        description = "管理员";
        # 添加用户到额外组
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
        hashedPassword = "$6$Yq2f2308VGQlSDxb$v6tOVrxDvVJYSB40g8t/n2ZVw9pSARf5Gxe.ph2n.TvyXDPiruSi8Y9pEuPNi0regGL8AB8dQBmge/kNTZqxh1";
      };
    };
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    # 导入用户配置
    users = {
      admin = import ./admin;
    };
    # 传递给子模块的参数
    extraSpecialArgs = {
      inherit inputs hostConfig pkgs-unstable;
    };
  };
}

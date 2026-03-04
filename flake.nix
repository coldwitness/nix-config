{
  description = "NixOS Flake Configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager?ref=master";
      # 使用与系统相同的 nixpkgs 输入, 避免依赖冲突
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixvim,
    ...
  }@inputs:
  {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        # 将 inputs 传递给模块
        specialArgs = {
          inherit inputs;
        };
        modules = [
          # 导入主配置
          ./configuration.nix
          # 导入其他模块
          nixvim.nixosModules.nixvim
          ./modules/nh.nix                # 
          ./modules/monitor.nix           # 
          ./modules/shell/fish.nix        # 终端
          ./modules/i18n/chinese.nix      # 本地化模块
          ./modules/editor/index.nix      # 编辑器模块
          ./modules/internet/index.nix    # 网络工具模块
          ./modules/desktop/index.nix     # 桌面模块
          # 导入 home-manager 模块
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            # 导入用户配置
            home-manager.users = {
              admin = import ./users/admin/home.nix;
            };
            # 在 home-manager 中使用 flake 的所有 inputs 参数
            home-manager.extraSpecialArgs = inputs;
          }
        ];
      }; 
    };
  };
}

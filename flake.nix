{
  description = "NixOS Flake Configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      # 使用与系统相同的 nixpkgs 输入, 避免依赖冲突
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
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
          ./modules/nh.nix
          ./modules/monitor.nix
          ./modules/i18n/chinese.nix
          ./modules/editor/vscode.nix
          ./modules/shell/fish.nix
          ./modules/internet/firefox.nix
          ./modules/desktop/hyprland.nix
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

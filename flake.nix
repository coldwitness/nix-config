{
  description = "NixOS Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      # 让 home-manager 的 nixpkgs 与系统相同的输入, 避免依赖冲突
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # 导入主配置
        ./configuration.nix
          # 导入其他模块
          ./chinese.nix
          ./hyprland/hyprland.nix
          # 导入 home-manager 模块
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            # 导入用户配置
            home-manager.users = {
              admin = import ./home/admin.nix;
            };
            # 在 home-manager 中使用 flake 的所有 inputs 参数
            home-manager.extraSpecialArgs = inputs;
          }
        ];
      }; 
    };
  };
}

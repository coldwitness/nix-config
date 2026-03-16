{
  description = "NixOS Flake Configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=master";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs?ref=nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager?ref=master";
      # 使用与系统相同的 nixpkgs 输入, 避免依赖冲突
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms = {
      url = "github:AvengeMedia/DankMaterialShell?ref=master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim?ref=main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mcp-nixos = {
      url = "github:utensils/mcp-nixos?ref=main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    secrets = {
      url = "git+ssh://git@github.com/knightfemale/nix-config-secrets.git";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }@inputs:
  let
    system = "x86_64-linux";
    # 主分支的 nixpkgs 实例(用于 pkgs 等)
    pkgs = nixpkgs.legacyPackages.${system};
    # 预构建 unstable 包集
    pkgs-unstable = import inputs.nixpkgs-unstable {
      inherit system;
      # 继承主系统的配置(如 allowUnfree)
      config = pkgs.config;
    };
  in
  {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        # 将 inputs 传递给模块
        specialArgs = {
          inherit inputs pkgs-unstable;
        };
        modules = [
          { 
            nixpkgs = {
              # 允许安装非自由软件包
              config.allowUnfree = true;
              # 指定 NixOS 配置将运行的平台
              hostPlatform = nixpkgs.lib.mkDefault system;
            };
          }
          ./users
          ./modules
          inputs.home-manager.nixosModules.home-manager
          inputs.dms.nixosModules.dank-material-shell
          inputs.nixvim.nixosModules.nixvim
        ];
      }; 
    };
  };
}

{
  description = "NixOS Flake Configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=master";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs?ref=nixpkgs-unstable";
    home-manager = {
      url = "git+ssh://git@github.com/nix-community/home-manager.git?ref=master";
      # 使用与系统相同的 nixpkgs 输入, 避免依赖冲突
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "git+ssh://git@github.com/nix-community/NUR.git?ref=main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms = {
      url = "git+ssh://git@github.com/AvengeMedia/DankMaterialShell.git?ref=master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "git+ssh://git@github.com/nix-community/nixvim.git?ref=main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mcp-nixos = {
      url = "git+ssh://git@github.com/utensils/mcp-nixos.git?ref=main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    secrets = {
      url = "git+ssh://git@github.com/nix-config/secrets.git?ref=master";
      flake = false;
    };
  };
  outputs = {
    self,
    nixpkgs,
    ...
  }@inputs:
  let
    hostConfig = import ./hosts/x86_64-linux;
    system = hostConfig.hardware.system;
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
      knightfemale-FL8850UA = nixpkgs.lib.nixosSystem {
        inherit system;
        # 传递给子模块的参数
        specialArgs = {
          inherit inputs hostConfig pkgs-unstable;
        };
        modules = [
          {
            nixpkgs = {
              # 允许安装非自由软件包
              config.allowUnfree = true;
              # 指定 NixOS 配置将运行的平台
              hostPlatform = nixpkgs.lib.mkDefault system;
            };
            # NixOS 首次安装的版本
            system.stateVersion = "25.11";
          }
          ./users
          ./modules
          inputs.nur.modules.nixos.default
        ];
      }; 
    };
  };
}

{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # 导入主配置
       ./configuration.nix
        # 导入其他模块
        ./chinese.nix
        ./hyprland.nix
      ];
    }; 
  };
}

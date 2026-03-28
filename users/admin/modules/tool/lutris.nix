{
  lib,
  pkgs,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.tool.lutris;
  finallyEnable = cfg.enable;
in
{
  config = lib.mkIf finallyEnable {
    programs.lutris = {
      enable = true;
      # 为 lutris 配合 umu-launcher 使用而添加的 proton 软件包列表
      protonPackages = with pkgs; [
        nur.repos.forkprince.proton-dw-bin
      ];
    };
    home.packages = with pkgs; [
      umu-launcher
    ];
  };
}

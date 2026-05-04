{
  lib,
  pkgs,
  opts,
  inputs,
  ...
}:
let
  cfg = opts.tool.lutris or { };
  finallyEnable = cfg.enable or false && ((opts.desktop.type or "") != "");
  nur = inputs.nur.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  inherit (nur.repos.forkprince) proton-dw-bin;
in
{
  config = lib.mkIf finallyEnable {
    programs.lutris = {
      enable = true;
      # 为 lutris 配合 umu-launcher 使用而添加的 proton 软件包列表
      protonPackages = [
        proton-dw-bin
      ];
    };
    home.packages = with pkgs; [
      umu-launcher
    ];
  };
}

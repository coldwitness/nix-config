{
  lib,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.cli.nix or { };
  substituters = cfg.substituters or [ ];
in
{
  nix.settings = {
    # 源配置
    inherit substituters;
    # 启用实验性功能
    experimental-features = [
      # nix 命令增强
      "nix-command"
      # flakes 支持
      "flakes"
    ];
  };
}

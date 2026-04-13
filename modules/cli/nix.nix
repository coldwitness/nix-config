{
  lib,
  opts,
  config,
  inputs,
  ...
}:
let
  cfg = opts.cli.nix or { };
  substituters = cfg.substituters or [ ];
in
{
  sops = {
    secrets."nix-extra-options.conf" = {
      sopsFile = ../../secrets/nix.ini;
      format = "ini";
      # 只有 root 和 sudo 用户可读
      owner = "root";
      group = "wheel";
      mode = "0440";
    };
  };
  nix = {
    settings = {
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
    # 通过 !include 包含运行时生成的配置文件(宽容模式, 如果指定的文件不存在 Nix 会忽略该指令)
    extraOptions = "!include ${config.sops.secrets."nix-extra-options.conf".path}";
  };
}

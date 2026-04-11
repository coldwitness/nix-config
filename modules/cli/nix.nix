{
  lib,
  opts,
  inputs,
  ...
}:
let
  cfg = opts.cli.nix or { };
  substituters = cfg.substituters or [ ];
  GITHUB_TOKEN = inputs.secrets.GITHUB_TOKEN or "";
  accessTokens =
    if GITHUB_TOKEN != ""
    then "access-tokens = github.com=${GITHUB_TOKEN}"
    else "";
in
{
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
    extraOptions = accessTokens;
  };
}

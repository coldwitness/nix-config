{
  lib,
  opts,
  config,
  ...
}:
let
  cfg = opts.cli.ssh or { };
  enableSopsNix = opts.service.sops-nix.enable or false;
  finallyEnable = cfg.enable or false && enableSopsNix;
  # 需要从同一个 yaml 中解密的 ssh 密钥名称列表
  sshSecretNames = [
    "ssh/id_ed25519"
    "ssh/id_ed25519_git"
    "ssh/id_ed25519_6309_4090D"
  ];
in
{
  config = lib.mkIf finallyEnable {
    sops.secrets =
      lib.genAttrs sshSecretNames (name: {
        sopsFile = ../../../secrets/ssh.yaml;
        format = "yaml";
        mode = "0400";
        path = "${config.home.homeDirectory}/.ssh/${builtins.baseNameOf name}";
      })
      // {
        "ssh/config" = {
          sopsFile = ../../../secrets/ssh.yaml;
          format = "yaml";
          mode = "0400";
          path = "${config.home.homeDirectory}/.ssh/config";
        };
      };
    programs.ssh = {
      enable = true;
      # 默认配置
      enableDefaultConfig = false;
    };
  };
}

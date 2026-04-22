{
  lib,
  opts,
  ...
}:
let
  cfg = opts.cli.zellij or { };
  finallyEnable = cfg.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    programs.zellij = {
      enable = true;
      # 是否在自动启动后附加到默认会话
      attachExistingSession = false;
      # 是否退出 Shell 时自动退出
      exitShellOnExit = false;
    };
  };
}

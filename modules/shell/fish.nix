{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs = {
    bash = {
      enable = true;
      interactiveShellInit = ''
        # 检查父进程不是 fish, 并且不是在执行脚本
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          # 如果是登录 shell, 传递 --login 参数
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
    };
    fish = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    starship
  ];
}

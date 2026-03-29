{
  lib,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.shell.fish;
  finallyEnable = cfg.enable;
in
{
  config = lib.mkIf finallyEnable {
    programs = {
      fish = {
        enable = true;
        # 在交互式期间初始化调用的 shell 脚本代码
        interactiveShellInit = ""
          # 忽略问候
          + "set -g fish_greeting\n";
        # 命令别名
        shellAliases = {
          cat = "bat";
          top = "btop";
          ls = "eza --icons --git";
          tree = "eza --icons --git -T";
        };
        # 自定义函数
        functions = {
          snapperm = {
            body = ''
              set -l choice (printf "1: 列出快照\n2: 创建快照\n3: 删除快照\n4: 回滚快照" | fzf --prompt="选择操作: " --height=8 --border)
              if test -z "$choice"
                  echo "已取消"
                  return 1
              end
              switch "$choice"
                  case "1: 列出快照"
                      sudo snapper -c home list
                  case "2: 创建快照"
                      echo -n "输入快照备注: "
                      read -l description
                      if test -z "$description"
                          echo "备注不能为空"
                          return 1
                      end
                      sudo snapper -c home create -c "$description"
                      echo "已创建快照: $description"
                  case "3: 删除快照"
                      set -l all_snaps (mktemp)
                      sudo snapper -c home list | tail -n +3 > $all_snaps
                      set -l selected (cat $all_snaps | fzf --prompt="选择要删除的快照: " --height=7 --border)
                      rm $all_snaps
                      if test -n "$selected"
                          set -l num (echo $selected | awk '{print $1}')
                          set -l description (echo $selected | awk '{print $12}')
                          sudo snapper -c home delete $num
                          echo "已删除快照: $description"
                      end
                  case "4: 回滚快照"
                      set -l all_snaps (mktemp)
                      sudo snapper -c home list | tail -n +3 > $all_snaps
                      set -l selected (cat $all_snaps | fzf --prompt="选择要回滚的快照: " --height=7 --border)
                      rm $all_snaps
                      if test -n "$selected"
                          set -l num (echo $selected | awk '{print $1}')
                          set -l description (echo $selected | awk '{print $12}')
                          sudo snapper -c home undochange $num..0
                          echo "已回滚到快照: $description"
                      end
              end
            '';
          };
        };
      };
      # 启用 fzf 集成
      fzf.enableFishIntegration = true;
      # 启用 eza 集成
      eza.enableFishIntegration = true;
      # 启用 yazi 集成
      yazi.enableFishIntegration = true;
      # 启用 starship 集成
      starship.enableFishIntegration = true;
    };
  };
}

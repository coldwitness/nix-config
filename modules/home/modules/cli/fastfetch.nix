{
  lib,
  pkgs,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.cli.fastfetch or { };
  finallyEnable = cfg.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    programs = {
      fastfetch = {
        enable = true;
        settings = {
          "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
          display = {
            # 分隔符
            separator = " ";
            size = {
              # 使用 KB/MB/GB
              binaryPrefix = "si";
              # 显示小数位数
              ndigits = 1;
            };
            percent = {
              # 百分比显示模式
              type = 2;
            };
            bar = {
              # 已用部分字符
              char.elapsed = "■";
              # 未用部分字符
              char.total = " ";
            };
            key = {
              # 键名对齐宽度
              width = 6;
            };
          };
          modules = [
            {
              type = "display";
              key = "╭─󰍹";
              keyColor = "green";
            }
            {
              type = "brightness";
              key = "├─󰃞";
              keyColor = "green";
            }
            {
              type = "battery";
              key = "├─";
              keyColor = "green";
            }
            {
              type = "poweradapter";
              key = "├─";
              keyColor = "green";
            }
            {
              type = "gamepad";
              key = "├─";
              keyColor = "green";
            }
            {
              type = "bluetooth";
              key = "├─";
              keyColor = "green";
            }
            {
              type = "sound";
              key = "├─";
              keyColor = "green";
            }
            {
              type = "host";
              key = "├─󰌢";
              keyColor = "green";
            }
            {
              type = "cpu";
              key = "├─󰻠";
              keyColor = "green";
            }
            {
              type = "gpu";
              key = "├─󰍛";
              keyColor = "green";
            }
            {
              type = "memory";
              key = "├─󰑭";
              keyColor = "green";
            }
            {
              type = "swap";
              key = "├─󰓡";
              keyColor = "green";
            }
            {
              type = "disk";
              key = "╰─";
              keyColor = "green";
            }
            "break"
            {
              type = "lm";
              key = "╭─󰧨";
              keyColor = "yellow";
            }
            {
              type = "de";
              key = "├─";
              keyColor = "yellow";
            }
            {
              type = "wm";
              key = "├─";
              keyColor = "yellow";
            }
            {
              type = "theme";
              key = "├─󰉼";
              keyColor = "yellow";
            }
            {
              type = "icons";
              key = "├─󰀻";
              keyColor = "yellow";
            }
            {
              type = "wallpaper";
              key = "├─󰸉";
              keyColor = "yellow";
            }
            {
              type = "terminal";
              key = "├─";
              keyColor = "yellow";
            }
            {
              type = "terminalfont";
              key = "├─";
              keyColor = "yellow";
            }
            {
              type = "shell";
              key = "╰─";
              keyColor = "yellow";
            }
            "break"
            {
              type = "title";
              key = "╭─";
              format = "{user-name}@{host-name}";
              keyColor = "blue";
            }
            {
              type = "os";
              key = "├─{icon}";
              keyColor = "blue";
            }
            {
              type = "kernel";
              key = "├─";
              keyColor = "blue";
            }
            {
              type = "packages";
              key = "├─󰏖";
              keyColor = "blue";
            }
            {
              type = "uptime";
              key = "├─󰅐";
              keyColor = "blue";
            }
            {
              type = "media";
              key = "├─󰝚";
              keyColor = "blue";
            }
            {
              type = "localip";
              key = "├─󰩟";
              compact = true;
              keyColor = "blue";
            }
            {
              type = "publicip";
              key = "├─󰩠";
              keyColor = "blue";
              timeout = 1000;
            }
            {
              type = "wifi";
              key = "├─";
              format = "{ssid}";
              keyColor = "blue";
            }
            {
              type = "locale";
              key = "╰─";
              keyColor = "blue";
            }
          ];
        };
      };
    };
  };
}

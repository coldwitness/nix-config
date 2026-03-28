{
  lib,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.terminal.kitty;
  finallyEnable = cfg.enable;
in
{
  config = lib.mkIf finallyEnable {
    programs = {
      kitty = {
        enable = true;
        settings = {
          # 设置背景透明度: 取值范围 0.0(完全透明)到 1.0(完全不透明)
          background_opacity = 0.75;
          # 光标形状: 可以将默认的方块(block)改成更细的竖线(beam)或下划线(underline)
          cursor_shape = "beam";
          # 打字时立即隐藏鼠标
          mouse_hide_wait = -1.0;
          # 指定 shell
          shell = "fish";
          # 设置背景颜色
          background = "#000000";
        };
      };
    };
  };
}

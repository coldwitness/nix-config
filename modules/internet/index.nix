{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
      # QQ
      ./qq.nix
      # 微信
      ./wechat.nix
      # 火狐浏览器
      ./firefox.nix
      # RustDesk 远程桌面
      ./rustdesk.nix
    ];
}

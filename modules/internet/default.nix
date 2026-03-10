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
      # 代理
      ./sing-box.nix
      # RustDesk 远程桌面
      ./rustdesk.nix
      # 虚拟局域网
      ./zerotierone.nix
    ];
}

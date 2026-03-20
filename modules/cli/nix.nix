{
  ...
}:
{
  nix.settings = {
    # 源配置
    substituters = [
    # "https://mirror.sjtu.edu.cn/nix-channels/store"
    # 添加中科大镜像源
    # "https://mirrors.ustc.edu.cn/nix-channels/store"
    # 清华大学镜像源
    # "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
    # 默认官方源
    "https://cache.nixos.org"
    ];
    # 启用实验性功能
    experimental-features = [
      # nix 命令增强
      "nix-command"
      # flakes 支持
      "flakes"
    ];
  };
}

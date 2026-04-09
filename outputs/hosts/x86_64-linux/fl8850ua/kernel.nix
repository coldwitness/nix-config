{
  lib,
  pkgs,
  ...
}:
{
  boot.kernelPackages = let
    # 定义一个函数, 用于构建自定义的内核包
    linux_lqx_pkg = { fetchurl, buildLinux, ... } @ args:
      #  调用 buildLinux 函数, 传入参数并覆盖部分属性
      buildLinux (args // rec {
        # 内核主版本号
        version = "6.19.11";
        # 模块目录版本
        modDirVersion = "${version}-lqx2";
        # 内核源代码的获取方式
        src = pkgs.fetchurl {
          url = "https://github.com/zen-kernel/zen-kernel/archive/refs/tags/v${modDirVersion}.tar.gz";
          sha256 = "sha256-SpxqXN3EE4y9sTROztmTHSinWqtEZRCUVo3emHNLVis=";
        };
        # 额外的内核补丁列表
        kernelPatches = [ ];
        # 配置自定义内核选项
        structuredExtraConfig = with lib.kernel; {
        # ========== 内核裁剪 ==========
          # GPS
          GNSS = no;
          # USB4 和 Thunderbolt 支持
          USB4 = no;
          # 火线
          FIREWIRE = no;
          # 触摸屏
          INPUT_TOUCHSCREEN = no;
        };
        #  添加内核包的元数据, 设置分支名便于识别
        extraMeta.branch = version;
        # 允许通过 argsOverride 进一步覆盖参数
      } // (args.argsOverride or { }));
    #  使用 pkgs.callPackage 调用上面定义的函数, 自动解析并传入所需的依赖
    linux_lqx = pkgs.callPackage linux_lqx_pkg { };
  in
  # 根据自定义内核生成完整的内核包集合
  # 然后使用 recurseIntoAttrs 让该属性集在 nix-env 等命令中被正确展开
  lib.recurseIntoAttrs (pkgs.linuxPackagesFor linux_lqx);
}

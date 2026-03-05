{
  config,
  lib,
  pkgs,
  ...
}:
let
  qq-wayland = pkgs.stdenv.mkDerivation {
    name = "qq-wayland";
    buildInputs = [ pkgs.gnused ];
    buildCommand = ''
      mkdir -p $out/bin $out/share/applications
      # 创建命令行脚本(终端输入 qq 时会自动带上参数)
      cat > $out/bin/qq <<EOF
      #!${pkgs.stdenv.shell}
      exec ${pkgs.qq}/bin/qq -enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime "\$@"
      EOF
      chmod +x $out/bin/qq
      # 复制并修改 desktop 文件
      cp ${pkgs.qq}/share/applications/qq.desktop $out/share/applications/
      substituteInPlace $out/share/applications/qq.desktop \
        --replace "Exec=${pkgs.qq}/bin/qq %U" \
        "Exec=qq -enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime %U"
    '';
    # 继承原始包的元数据
    meta = pkgs.qq.meta;
  };
in
{
  environment.systemPackages = with pkgs; [
    qq-wayland
  ];
}

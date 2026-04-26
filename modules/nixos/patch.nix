{
  inputs,
  ...
}:
{
  nixpkgs.overlays = [
    # 修复 openldap 测试不稳定
    (final: prev: {
      openldap = prev.openldap.overrideAttrs (_: {
        doCheck = false;
      });
    })
  ];
}

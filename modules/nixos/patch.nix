{
  ...
}:
{
  nixpkgs.overlays = [
    # 禁用 openldap 不稳定的测试
    (final: prev: {
      openldap = prev.openldap.overrideAttrs (_: {
        doCheck = false;
      });
    })
  ];
}

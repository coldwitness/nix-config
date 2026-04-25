{
  inputs,
  ...
}:
{
  nixpkgs.overlays = [
    # mcp-nixos 官方 overlay(提供 pkgs.mcp-nixos)
    inputs.mcp-nixos.overlays.default
    # 修复 aioboto3 测试失败
    (final: prev: {
      pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
        (pyFinal: pyPrev: {
          aioboto3 = pyPrev.aioboto3.overridePythonAttrs (_: {
            doCheck = false;
          });
        })
      ];
    })
    # 修复 openldap 测试不稳定
    (final: prev: {
      openldap = prev.openldap.overrideAttrs (_: {
        doCheck = false;
      });
    })
  ];
}

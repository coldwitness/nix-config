{
  inputs,
  ...
}:
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];
  # 将 SSH 密钥自动导入为 age 密钥
  sops.age.sshKeyPaths = [ "/home/admin/.ssh/id_ed25519" ];
}

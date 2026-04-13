{
  ...
}:
{
  # 提供一个基础用户组
  users = {
    root = {
      # 哈希密码
      hashedPassword = "$6$yk.jU.kxIAVwaoaj$zFEdwFofY8P88Ad7/a62sm5j3QxyXcQxKTvTpRMIYDgw6G4RDXZCQgHRyeOyZHLN10lKov55WJESL8t2Ia1US0";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEHoElqa20vBDgApV3Ek5XEP7xjPyOS+FiVxLOSsHoIK"
      ];
    };
    admin = {
      # 普通用户
      isNormalUser = true;
      # 用户描述
      description = "管理员";
      # 添加用户到额外组
      extraGroups = [
        "wheel"
      ];
      hashedPassword = "$6$Yq2f2308VGQlSDxb$v6tOVrxDvVJYSB40g8t/n2ZVw9pSARf5Gxe.ph2n.TvyXDPiruSi8Y9pEuPNi0regGL8AB8dQBmge/kNTZqxh1";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEHoElqa20vBDgApV3Ek5XEP7xjPyOS+FiVxLOSsHoIK"
      ];
    };
  };
}

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
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCvQqWUftAAIIjgqAJJtliE4j8bCzOf7kwAuyyaDoT4EdceNX3ZHHWn6jv/jfBPBsyEn1PCbhu80NYExWxlSMbEQyMdbkZzj5yI19pWZkh6fXAukRYnfckO1uRIQmHKsqWv4P+ndsQ/lUNvlMyCDAO0bj/XXOTwYLrXAQQZjXV5Kj8PXgWCBqAQjC8ucfREb3QgO1jcTIerC8Q49S3pWZ3JQDzJmeqKb1nOlXwy4oh9Q3Ax8mFRCG1lE7nbtXFAHOAdpi1Jj4Y8WhXpVbfw0REDry5gP3RnH2YnLqY9oP6qLD2J851TCpoaP5Dzn9dB2KnmMSu+9VdhL9p6r4cxrosgqQEvYzn9djBQKQyX1rx0yljbT6G+FEOqrkuCZWSE6gGmii5YDqKmOJA4MzrIV6Yf4yMVGmlAQEx9z2GuirB7hOhrhWtd1raXsBlzyAtTxra+25fGGF3074L0IfNNbJMo3y54LkqzvAoLCNbBsAGfUureGTvisIm5nqaZkT9QdZxzPzLZKKGyb7o0TM2ffRiokeZNoz2WZXtlI4a5FrsBb8MrIUa+pYaR0h3vB8fgsEXe2/z2ZusdBv1ZRj+BQjHK28K5QVojEjb2as+8q78z3H0LgcPv+F6Y/BejczE0zLxA4wzwZZKJpi2oUKIfASJLmxpH2rydoYVyLAnLpFsXzQ=="
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
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCvQqWUftAAIIjgqAJJtliE4j8bCzOf7kwAuyyaDoT4EdceNX3ZHHWn6jv/jfBPBsyEn1PCbhu80NYExWxlSMbEQyMdbkZzj5yI19pWZkh6fXAukRYnfckO1uRIQmHKsqWv4P+ndsQ/lUNvlMyCDAO0bj/XXOTwYLrXAQQZjXV5Kj8PXgWCBqAQjC8ucfREb3QgO1jcTIerC8Q49S3pWZ3JQDzJmeqKb1nOlXwy4oh9Q3Ax8mFRCG1lE7nbtXFAHOAdpi1Jj4Y8WhXpVbfw0REDry5gP3RnH2YnLqY9oP6qLD2J851TCpoaP5Dzn9dB2KnmMSu+9VdhL9p6r4cxrosgqQEvYzn9djBQKQyX1rx0yljbT6G+FEOqrkuCZWSE6gGmii5YDqKmOJA4MzrIV6Yf4yMVGmlAQEx9z2GuirB7hOhrhWtd1raXsBlzyAtTxra+25fGGF3074L0IfNNbJMo3y54LkqzvAoLCNbBsAGfUureGTvisIm5nqaZkT9QdZxzPzLZKKGyb7o0TM2ffRiokeZNoz2WZXtlI4a5FrsBb8MrIUa+pYaR0h3vB8fgsEXe2/z2ZusdBv1ZRj+BQjHK28K5QVojEjb2as+8q78z3H0LgcPv+F6Y/BejczE0zLxA4wzwZZKJpi2oUKIfASJLmxpH2rydoYVyLAnLpFsXzQ=="
      ];
    };
  };
}

{
  ...
}:
{
  # 禁用 logrotate 服务在生成配置后的语法检查
  services.logrotate.checkConfig = false;
  # 在每次系统启动时清空 /tmp 目录
  boot.tmp.cleanOnBoot = true;
}

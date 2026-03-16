{
  ...
}:
let
  systemBootDevice = "/dev/disk/by-uuid/027B-7471";
  systemFileDevice = "/dev/disk/by-uuid/8c18bbfc-4114-497a-b34b-760429d94a25";
in 
{
  # 要挂载的文件系统
  fileSystems = {
    "/boot" = {
      device = systemBootDevice;
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
    "/" = {
      device = systemFileDevice;
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };
    "/home" = {
      device = systemFileDevice;
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };
    "/nix" = {
      device = systemFileDevice;
      fsType = "btrfs";
      options = [ "subvol=@nix" ];
    };
    "/var/log" = {
      device = systemFileDevice;
      fsType = "btrfs";
      options = [ "subvol=@log" ];
    };
    "/.snapshots" = {
      device = systemFileDevice;
      fsType = "btrfs";
      options = [ "subvol=@.snapshots" ];
    };
    "/swap" = {
      device = systemFileDevice;
      fsType = "btrfs";
      options = [ "subvol=@swap" ];
    };
  };
  # 交换设备和交换文件
  swapDevices = [ { device = "/swap/swapfile"; } ];
}

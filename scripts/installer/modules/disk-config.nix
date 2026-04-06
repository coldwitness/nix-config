{
  disk,
  ...
}:
{
  disko.devices = {
    disk.main = {
      type = "disk";
      # 动态接收磁盘设备
      device = disk;
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            size = "1G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "fmask=0022" "dmask=0022" ];
            };
          };
          root = {
            # 剩余所有空间
            size = "100%";
            content = {
              type = "btrfs";
              # 覆盖现有分区
              extraArgs = [ "-f" ];
              subvolumes = {
                "@" = {
                  mountpoint = "/";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "@snapshots" = {
                  mountpoint = "/.snapshots";
                  mountOptions = [ "compress=zstd" ];
                };
                "@home" = {
                  mountpoint = "/home";
                  mountOptions = [ "compress=zstd" ];
                };
                "@home-snapshots" = {
                  mountpoint = "/home/.snapshots";
                  mountOptions = [ "compress=zstd" ];
                };
                "@nix" = {
                  mountpoint = "/nix";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "@log" = {
                  mountpoint = "/var/log";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "@swap" = {
                  mountpoint = "/.swap";
                  mountOptions = [ "nodatacow" ];
                  swap.swapfile = {
                    size = "4G";
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}

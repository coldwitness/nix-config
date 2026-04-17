{
  vars,
  optSets,
  hostName,
  ...
}:
let
  host = {
    count = 1;
    system = vars.systemTypes.x86_64-linux;
    stateVersion = "25.11";
    customOptSets = {
      nixConfigPath = "home/admin/workspace/nix-config";
      cli = {
        nix = {
          substituters = [
            "https://mirror.sjtu.edu.cn/nix-channels/store"
            "https://cache.garnix.io"
          ];
          trusted-public-keys = [
            "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
          ];
        };
      };
      tool.clash-verge.enable = true;
      i18n.locale = vars.localeTypes.en-us;
      service = {
        openssh.enable = true;
        spos-nix.enable = true;
        frp = {
          enable = true;
          role = vars.frpRoleTypes.server;
        };
        zerotierone = {
          enable = true;
          joinNetworks = [ "98c7dece649d0152" ];
        };
        rustdesk-server = {
          enable = true;
          relayHosts = [ "knightfemale.com:21117" ];
        };
      };
      hardware = {
        zram.enable = true;
        graphics = {
          type = vars.gpuTypes.none;
        };
        networking = {
          domain = "";
          inherit hostName;
          networkmanager.enable = false;
          firewall = {
            enable = false;
          };
        };
        boot-loader = {
          efiSysMountPoint = "/boot/efi";
          type = vars.bootLoaderTypes.systemd-boot;
        };
      };
    };
  };
  users = {
    root = {
      base = {
        hashedPassword = "$6$yk.jU.kxIAVwaoaj$zFEdwFofY8P88Ad7/a62sm5j3QxyXcQxKTvTpRMIYDgw6G4RDXZCQgHRyeOyZHLN10lKov55WJESL8t2Ia1US0";
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEHoElqa20vBDgApV3Ek5XEP7xjPyOS+FiVxLOSsHoIK"
        ];
      };
    };
    admin = {
      base = {
        isNormalUser = true;
        description = "管理员";
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
        hashedPassword = "$6$a46xJM8CZ80Jplk2$BiG06wUNzicRYKStqIh0vV2ZE87NHQyvh27jD.gJawiu8wGrFw6zNunzpNb7aXhjyU.4x/UZZvFT05rEAjzGT0";
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEHoElqa20vBDgApV3Ek5XEP7xjPyOS+FiVxLOSsHoIK"
        ];
      };
      count = 1;
      predefinedOptSetsList = [
        optSets.baseEnv
        optSets.fishShell
      ];
      customOptSets = {
        cli = {
          tmux.enable = true;
        };
      };
    };
  };
in
{
  inherit host;
  inherit users;
}

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
      nixConfigPath = "/home/admin/workspace/nix-config";
      cli = {
        nix = {
          substituters = [
            "https://cache.garnix.io"
          ];
          trusted-public-keys = [
            "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
          ];
        };
      };
      tool.clash-verge.enable = true;
      i18n.locale = vars.localeTypes.zh-cn;
      desktop = {
        type = vars.desktopTypes.hyprland;
        dms.enable = true;
      };
      service = {
        greetd.enable = true;
        logind.enable = true;
        openssh.enable = true;
        snapper.enable = true;
        udiskie.enable = true;
        pipewire.enable = true;
        libinput.enable = true;
        spos-nix.enable = true;
        frp = {
          enable = true;
          role = vars.frpRoleTypes.client;
          proxies = [
            {
              name = "ssh-fl8850ua";
              type = "tcp";
              localIP = "localhost";
              localPort = 22;
              remotePort = 2222;
            }
          ];
        };
        zerotierone = {
          enable = true;
          joinNetworks = [ "98c7dece649d0152" ];
        };
      };
      hardware = {
        zram.enable = true;
        bluetooth.enable = true;
        graphics = {
          enable = true;
          enable32Bit = true;
          type = vars.gpuTypes.amd;
        };
        networking = {
          inherit hostName;
          networkmanager.enable = true;
          firewall.enable = false;
        };
        boot-loader = {
          efiSysMountPoint = "/boot";
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
        optSets.devEnv
        optSets.baseEnv
        optSets.fishShell
      ];
      customOptSets = {
        cli = {
          ssh.enable = true;
          tmux.enable = true;
          opencode.enable = true;
        };
        tool = {
          fcitx5.enable = true;
          lutris.enable = true;
        };
        media = {
          mpv.enable = true;
          spotify.enable = true;
          obs-studio.enable = true;
        };
        editor.vscode.enable = true;
        terminal.kitty.enable = true;
        internet = {
          qq.enable = true;
          wechat.enable = true;
          firefox.enable = true;
          rustdesk.enable = true;
          telegram-desktop.enable = true;
        };
      };
    };
  };
in
{
  inherit host;
  inherit users;
}

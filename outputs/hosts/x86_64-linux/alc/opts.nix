{
  inputs,
  hostName,
  ...
}:
let
  vars = import ../../../../vars { inherit inputs; };
  optSets = import ../../../optSets { inherit inputs; };
  functions = import ../../../../functions { inherit inputs; };
  predefinedOptSetsList = [
    optSets.baseEnv
    optSets.fishShell
    optSets.baseUsers
  ];
  customOptSets = {
    nixConfigPath = "/home/admin/workspace/nix-config";
    cli = {
      tmux.enable = true;
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
    i18n = {
      locale = vars.localeTypes.en-us;
    };
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
  opts = functions.mergeOptSetsList customOptSets predefinedOptSetsList;
in
opts

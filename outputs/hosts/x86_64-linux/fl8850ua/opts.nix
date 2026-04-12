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
  customOptSets ={
    nixConfigPath = "/home/admin/workspace/nix-config";
    users = {
      admin.extraGroups = [
        "networkmanager"
      ];
    };
    cli = {
      ssh.enable = true;
      tmux.enable = true;
      opencode.enable = true;
      mcp-nixos.enable = true;
      nix.substituters = [
        "https://cache.nixos.org"
      ];
    };
    tool = {
      fcitx5.enable = true;
      lutris.enable = true;
      clash-verge.enable = true;
    };
    i18n = {
      locale = vars.localeTypes.zh-cn;
    };
    media = {
      mpv.enable = true;
      spotify.enable = true;
      obs-studio.enable = true;
    };
    editor = {
      vscode.enable = true;
    };
    desktop = {
      type = vars.desktopTypes.hyprland;
      dms = {
        enable = true;
      };
    };
    terminal = {
      kitty.enable = true;
    };
    service = {
      frp.enable = true;
      greetd.enable = true;
      logind.enable = true;
      openssh.enable = true;
      snapper.enable = true;
      udiskie.enable = true;
      pipewire.enable = true;
      libinput.enable = true;
      zerotierone.enable = true;
    };
    internet = {
      qq.enable = true;
      wechat.enable = true;
      firefox.enable = true;
      rustdesk.enable = true;
      telegram-desktop.enable = true;
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
        firewall = {
          enable = false;
        };
      };
      boot-loader = {
        efiSysMountPoint = "/boot";
        type = vars.bootLoaderTypes.systemd-boot;
      };
    };
  };
  opts = functions.mergeOptSetsList customOptSets predefinedOptSetsList;
in
opts

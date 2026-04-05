# Nix 配置

基于 Flakes 的 Nix 配置文件，支持多主机管理。

![桌面截图](https://picui.ogmua.cn/s1/2026/04/01/69ccf0a37b909.webp)

## 目录结构

```bash
.
├── outputs/                                    # Flake 输出
│   └── <platform>/                             # 系统架构
│       ├── hosts/                              # 主机
│       │   └── <host>/                         # 具体主机
│       │       ├── default.nix                 # 主机输出入口
│       │       ├── hostOptions.nix             # 主机选项定义
│       │       └── hardware-configuration.nix  # 主机硬件配置
│       └── users/                              # 用户
│           └── <user>/                         # 具体用户
│               ├── default.nix                 # 用户输出入口
│               └── hostOptions.nix             # 用户选项定义
├── modules/                                    # 系统模块
│   ├──<category>/                              # 模块分类
│   └──home/
│      ├──modules/                              # 用户模块
│      │  └──<category>/
│      └──config/                               # 原生配置文件
├── vars/                                       # 公共变量
├── functions/                                  # 工具函数
├── secrets/                                    # 私密信息(采用子模块)
├── installer/                                  # 安装脚本
├── flake.nix                                   # Flake 输入
├── flake.lock                                  # Flake 版本锁
└── justfile                                    # 快捷命令
```

## 安装教程

本项目提供两阶段安装流程，通过交互式脚本简化安装过程。

### 第一阶段：LiveCD 安装

#### 1. 环境准备

满足以下配置要求：

| 配置         | 最低   | 推荐               |
| ------------ | ------ | ------------------ |
| CPU          | 2 核心 | 8 核心             |
| 内存         | 2 GB   | 8 GB (1 核心/1 GB) |
| 硬盘(无桌面) | 10 GB  | 20 GB 以上         |
| 硬盘(有桌面) | 25 GB  | 50 GB 以上         |

- 下载 NixOS LiveCD 镜像（较新的如 25.11 或 unstable 都可以）
- 使用 Ventoy（推荐）、Rufus 或 Etcher 将镜像写入 U 盘
- 从 U 盘启动电脑，进入 LiveCD 环境

**如果使用虚拟机，注意查看下方常见问题的虚拟机相关！**

#### 2. 连接网络

```bash
# 切换到 root 账户
sudo -i

# 检查网络状态
ping -c 3 8.8.8.8

# 如需配置 WiFi，使用 nmtui
nmtui
```

**注意**：第一阶段安装脚本使用国内镜像源，**只需国内网络连接即可**，无需代理。

#### 3. 克隆仓库并运行安装脚本

```bash
# 克隆配置仓库
git clone https://github.com/nix-config/nix-config.git
# 或者使用 gitee
git clone https://gitee.com/nix-config/nix-config.git

# 运行交互式安装脚本
cd nix-config/installer/
bash livecd-installer.sh
```

脚本会自动：

- 检测可用磁盘设备
- 让你选择安装目标磁盘
- 使用 Disko 进行分区、格式化、挂载
- 生成 NixOS 配置文件
- 安装系统

**安装完成后提示需要输入初始密码，实际上不管输入什么重启后都会变为声明的`passwd`！**

#### 4. 自定义磁盘布局

默认使用 Btrfs 文件系统，分区方案如下：

| 分区 | 大小     | 文件系统 | 挂载点 | 备注         |
| ---- | -------- | -------- | ------ | ------------ |
| ESP  | 1GB      | vfat     | /boot  | EFI 系统分区 |
| root | 剩余空间 | btrfs    | /      | 含多个子卷   |

Btrfs 子卷结构：

| 子卷            | 挂载点           | 挂载选项              |
| --------------- | ---------------- | --------------------- |
| @               | /                | compress=zstd,noatime |
| @snapshots      | /.snapshots      | compress=zstd         |
| @home           | /home            | compress=zstd         |
| @home-snapshots | /home/.snapshots | compress=zstd         |
| @nix            | /nix             | compress=zstd,noatime |
| @log            | /var/log         | compress=zstd,noatime |
| @swap           | /.swap           | nodatacow             |

如需修改默认分区方案，编辑 `installer/modules/disk-config.nix` 调整：

- 分区大小
- 文件系统类型
- 子卷结构
- 挂载选项

### 第二阶段：系统配置

#### 1. 重启进入新系统

安装完成后重启，首次登录使用默认用户：

- **用户名**：`admin` 或 `root`(不推荐)
- **密码**：`passwd`

#### 2. 克隆仓库并运行配置脚本

```bash
# 克隆配置仓库
git clone https://github.com/nix-config/nix-config.git
# 或者使用 gitee
git clone https://gitee.com/nix-config/nix-config.git

# 运行配置脚本
cd nix-config/installer/
bash installer.sh
```

脚本会自动：

- 复制硬件配置文件到 `outputs/<platform>/nixos/`
- 初始化 `secrets` 子模块
- 使用 `nixos-rebuild switch --flake .#nixos` 应用配置

**如需自定义主机输出或自定义用户，建议创建自己的 Git 分支！**

### 自定义主机输出

#### 1. 复制默认主机输出配置

```bash
# 复制 nixos 模板到新目录
cp -r outputs/<platform>/hosts/nixos outputs/<platform>/hosts/<hostname>
```

#### 2. 修改配置

编辑 `outputs/<platform>/hosts/<hostname>/default.nix`：

```nix
nixosConfigurations = {
  # 将 nixos 改为你的主机名
  <hostname> = lib.nixosSystem {
    ...
  };
};
```

编辑 `outputs/<platform>/hosts/<hostname>/hostOptions.nix`，根据需要调整模块开关。

如需修改默认密码，使用以下命令生成密码哈希：

```bash
# 生成 SHA-512 密码哈希
mkpasswd -m sha-512
```

然后将生成的哈希值替换到 `outputs/<platform>/hosts/<hostname>/hostOptions.nix` 中的对应位置：

```nix
hostOptions.users.admin.hashedPassword = "生成的哈希值";
hostOptions.users.root.hashedPassword = "生成的哈希值";
```

#### 3. 应用配置

```bash
# 暂存更改
git add --all

# 在项目根目录运行
sudo nixos-rebuild switch --flake .#<hostname>
# 或者
just rebuild
```

### 自定义用户

#### 1. 修改主机输出配置

用户配置通过 `hostOptions.users` 动态定义，在 `outputs/<platform>/hosts/<hostname>/hostOptions.nix` 的 `users` 部分添加新用户：

```nix
users = {
  ...
  # 添加新用户
  <username> = {
    ...
  };
};
```

#### 2. 添加用户配置

为新用户配置在 `outputs/<platform>/users/` 目录下创建对应名称的模块目录，并参考 `admin/` 修改。

```bash
mkdir outputs/<platform>/users/<username>
# 你也可以
cp -r outputs/<platform>/users/admin outputs/<platform>/users/<username>
```

#### 3. 应用配置

```bash
# 暂存更改
git add --all

# 在项目根目录运行
sudo nixos-rebuild switch --flake .#<hostname>
# 或者
just rebuild
```

## 常见问题

### 日常使用相关

#### Q: 如何更新系统？

```bash
just update

# 如果将本仓库作为上游
git fetch
# 合并以及处理冲突后
just rebuild
```

#### Q: 如何清理系统？

```bash
just clean
```

### 虚拟机相关

#### Q: 没有网络怎么办？

编辑 `hostOptions.nix`：

```nix
hardware.networking.networkmanager.enable = false;
```

#### Q: 终端打不开怎么办？

编辑 `hostOptions.nix`：

```nix
terminal = {
  foot.enable = true;
  kitty.enable = false;
};
```

#### Q: DMS 启动失败怎么办？

编辑 `hostOptions.nix`：

```nix
desktop.dms.softwareRenderingEnable = true;
```

## 相关链接

- [NixOS 官方文档](https://nixos.org/manual/nixos/stable/)
- [Disko 文档](https://github.com/nix-community/disko)
- [Home Manager 文档](https://nix-community.github.io/home-manager/)
- [Nix Flakes 文档](https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-flake)

[![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/nix-config/nix-config)

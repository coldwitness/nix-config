# 📦 安装指南

[⬅️ 返回主文档](../../README.md)

---

## 📑 目录

- [1. 硬件要求](#1-硬件要求)
- [2. LiveCD 安装](#2-livecd-安装)
  - [2.1 环境准备](#21-环境准备)
  - [2.2 连接网络](#22-连接网络)
  - [2.3 克隆仓库](#23-克隆仓库)
  - [2.4 运行安装脚本](#24-运行安装脚本)
  - [2.5 脚本自动完成的操作](#25-脚本自动完成的操作)
  - [2.6 密码设置提示](#26-密码设置提示)
- [3. 应用 Flake 配置](#3-应用-flake-配置)
  - [3.1 重启后登录](#31-重启后登录)
  - [3.2 克隆并运行配置脚本](#32-克隆并运行配置脚本)
  - [3.3 自定义建议](#33-自定义建议)
  - [3.4 脚本自动完成的操作](#34-脚本自动完成的操作)
- [4. 自定义磁盘布局](#4-自定义磁盘布局)
  - [4.1 默认 Btrfs 方案](#41-默认-btrfs-方案)
  - [4.2 分区表结构](#42-分区表结构)
  - [4.3 Btrfs 子卷结构](#43-btrfs-子卷结构)
  - [4.4 如何修改默认布局](#44-如何修改默认布局)

---

## 1. 硬件要求

在开始安装之前，请确保你的硬件满足以下最低要求：

| 配置         | 最低   | 推荐               |
| ------------ | ------ | ------------------ |
| CPU          | 2 核心 | 8 核心             |
| 内存         | 2 GB   | 8 GB (1 核心/1 GB) |
| 硬盘(无桌面) | 10 GB  | 20 GB 以上         |
| 硬盘(有桌面) | 25 GB  | 50 GB 以上         |

> **💡 提示**：NixOS 的构建过程会消耗较多内存和 CPU 资源。如果计划进行大量编译或使用图形界面环境，建议使用推荐配置。

---

## 2. LiveCD 安装

本阶段将在 NixOS LiveCD 环境中完成系统的基础安装。

### 2.1 环境准备

#### 步骤 1：下载 NixOS 镜像

访问 [NixOS 官方下载页面](https://nixos.org/download/) 下载最新的 LiveCD 镜像：

- **推荐版本**：NixOS 25.11 或更新版本
- **镜像类型**：选择不带图形界面的 ISO（约 1GB+）

#### 步骤 2：制作启动盘

使用以下工具之一将镜像写入 U 盘（**至少 2GB**）：

| 工具           | 平台        | 特点                   |
| -------------- | ----------- | ---------------------- |
| Ventoy（推荐） | 跨平台      | 直接拷贝 ISO 文件即可  |
| Rufus          | Windows     | 功能强大，支持多种格式 |
| Etcher         | 跨平台      | 简单易用，图形化界面   |
| dd             | Linux/macOS | 命令行方式             |

### 2.2 连接网络

LiveCD 环境启动后，首先需要确保网络连接正常。

#### 有线网络（自动连接）

大多数情况下，插入网线后会自动获取 IP 地址。验证连接：

```bash
# 测试网络连通性
ping -c 3 8.8.8.8
```

#### 无线网络（WiFi）

如果需要使用 WiFi，使用 `nmtui` 图形化工具配置：

```bash
# 启动 NetworkManager TUI
nmtui
```

> **💡 提示**：LiveCD 安装脚本使用国内镜像源（上海交大、中科大、清华大学），只需确保国内网络连接即可，无需访问外网。

### 2.3 克隆仓库

网络连接成功后，克隆本项目到本地：

```bash
# 切换到 root 用户
sudo -i

# 方式一：GitHub 源（推荐）
git clone https://github.com/nix-config/nix-config.git

# 方式二：Gitee 源（国内加速）
git clone https://gitee.com/nix-config/nix-config.git

# 进入安装目录
cd nix-config/scripts/installer/
```

> **💡 提示**：如果需要自定义磁盘布局，请查看下方的 [自定义磁盘布局](#4-自定义磁盘布局) 按需更改。

### 2.4 运行安装脚本

```bash
bash livecd-installer.sh
```

### 2.5 脚本自动完成的操作

[livecd-installer.sh](./livecd-installer.sh) 脚本会自动完成以下操作：

| 操作内容            | 详细说明                                                                                       |
| ------------------- | ---------------------------------------------------------------------------------------------- |
| **检测磁盘设备**    | 使用 `lsblk` 列出所有可用磁盘                                                                  |
| **交互式选择磁盘**  | 让你选择要安装的目标磁盘（**⚠️ 此操作将清除该磁盘所有数据**）                                  |
| **卸载已挂载分区**  | 自动检测并卸载目标磁盘上已挂载的分区                                                           |
| **使用 Disko 分区** | 调用 [disk-config.nix](./modules/disk-config.nix) 定义的布局进行分区、格式化和挂载             |
| **生成基础配置**    | 运行 `nixos-generate-config` 生成 hardware-configuration.nix                                   |
| **复制额外配置**    | 将 [extra-configuration.nix](./modules/extra-configuration.nix) 复制到目标系统                 |
| **集成额外配置**    | 自动修改 configuration.nix 以引用 [extra-configuration.nix](./modules/extra-configuration.nix) |
| **安装系统**        | 运行 `nixos-install` 将系统安装到目标磁盘                                                      |

### 2.6 密码设置提示

安装过程中会提示你设置 root 密码：

```bash
setting password...
New password:
Retype new password:
```

> **💡 提示**：通常此处设置的密码是**临时密码**，仅用于首次登录。但实际上重启后系统将使用 [extra-configuration.nix](./modules/extra-configuration.nix) 中声明的哈希密码。

---

## 3. 应用 Flake 配置

LiveCD 安装完成后，重启进入新安装的系统，完成最终的配置初始化。

### 3.1 重启后登录

安装完成后，移除 U 盘并重启系统：

首次登录信息：

| 项目       | 值                |
| ---------- | ----------------- |
| **用户名** | `admin` 或 `root` |
| **密码**   | `passwd`          |

### 3.2 克隆并运行配置脚本

登录系统后，再次克隆仓库并运行脚本：

```bash
# 克隆仓库
git clone https://github.com/nix-config/nix-config.git
# 或使用 Gitee
git clone https://gitee.com/nix-config/nix-config.git

# 进入安装目录
cd nix-config/scripts/installer/

# 运行配置脚本
bash installer.sh
```

### 3.3 自定义建议

运行脚本前，强烈建议进行以下自定义操作：

#### 创建个人分支

```bash
# 创建并切换到自己的分支
git checkout -b <branch>
```

#### 配置主机选项

编辑主机配置文件来更改所需模块：

```bash
# 编辑主机选项
nano outputs/<platform>/hosts/<host>/opts.nix
```

详细的选项说明和完整配置示例请参阅 [主机管理](../../outputs/hosts/README.md)。

### 3.4 脚本自动完成的操作

[installer.sh](./installer.sh) 脚本会自动完成以下操作：

| 操作内容               | 详细说明                                                                        |
| ---------------------- | ------------------------------------------------------------------------------- |
| **复制硬件配置**       | 将 `/etc/nixos/hardware-configuration.nix` 复制到 `outputs/x86_64-linux/nixos/` |
| **生成 Secrets Flake** | 从模板创建 `secrets/flake.nix` 并初始化 Git 仓库                                |
| **提交配置更改**       | 将所有配置文件添加到 Git（排除 secrets 目录）                                   |
| **重建系统**           | 使用 `nh os switch . --ask --max-jobs 1` 应用新的 flake 配置                    |

---

## 4. 自定义磁盘布局

本项目默认使用 Btrfs 文件系统配合 Disko 进行声明式磁盘管理。

### 4.1 默认 Btrfs 方案

默认方案采用 **Btrfs + 子卷** 的设计，具有以下优势：

- **快照支持**：可以轻松创建系统快照用于备份和回滚
- **压缩存储**：使用 Zstd 压缩算法节省磁盘空间
- **CoW（写时复制）**：高效的文件写入性能
- **灵活的子卷组织**：逻辑分离不同用途的数据

### 4.2 分区表结构

默认分区表采用 GPT 格式，包含两个主要分区：

| 分区 | 大小     | 文件系统 | 类型代码 | 挂载点 | 用途         |
| ---- | -------- | -------- | -------- | ------ | ------------ |
| ESP  | 1 GB     | vfat     | EF00     | /boot  | EFI 系统分区 |
| root | 剩余空间 | btrfs    | -        | /      | 根文件系统   |

### 4.3 Btrfs 子卷结构

根分区使用 Btrfs 文件系统，并创建了多个子卷以实现逻辑分离：

| 子卷名称          | 挂载点             | 挂载选项                   | 用途说明     |
| ----------------- | ------------------ | -------------------------- | ------------ |
| `@`               | `/`                | `compress=zstd`, `noatime` | 系统根目录   |
| `@snapshots`      | `/.snapshots`      | `compress=zstd`            | 系统快照     |
| `@home`           | `/home`            | `compress=zstd`            | 用户家目录   |
| `@home-snapshots` | `/home/.snapshots` | `compress=zstd`            | 用户数据快照 |
| `@nix`            | `/nix`             | `compress=zstd`, `noatime` | Nix 包存储区 |
| `@log`            | `/var/log`         | `compress=zstd`, `noatime` | 系统日志     |
| `@swap`           | `/.swap`           | `nodatacow`                | Swap 文件    |

**挂载选项说明**：

| 选项            | 说明                                           |
| --------------- | ---------------------------------------------- |
| `compress=zstd` | 使用 Zstd 算法压缩数据，节省空间并提升读取性能 |
| `noatime`       | 不更新文件访问时间戳，减少 I/O 写入            |
| `nodatacow`     | 禁用写时复制（仅用于 swap，提升性能）          |

### 4.4 如何修改默认布局

如需自定义磁盘布局，编辑 [disk-config.nix](./modules/disk-config.nix) 文件。

> **💡 提示**：如果已经运行 [livecd-installer.sh](./livecd-installer.sh)，修改磁盘布局后，需要重新运行安装脚本才能生效。请务必备份重要数据！

---

<div align="center">

### 祝你安装顺利！🎉

如有问题，欢迎查阅 [常见问题](../../docs/faq.md) 或提交 Issue

</div>

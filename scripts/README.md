# 📜 脚本指南

[⬅️ 返回主文档](../README.md)

---

## 📑 目录

- [1. 脚本概览](#1-脚本概览)
- [2. 安装脚本 (installer.sh)](#2-安装脚本-installersh)
  - [2.1 脚本总览](#21-脚本总览)
  - [2.2 硬件要求](#22-硬件要求)
  - [2.3 脚本详细说明](#23-脚本详细说明)
    - [2.3.1 模式 1: LiveCD Install — LiveCD 环境下的全量安装](#231-模式-1-livecd-install--livecd-环境下的全量安装)
      - [2.3.1.1 环境准备](#2311-环境准备)
      - [2.3.1.2 连接网络](#2312-连接网络)
      - [2.3.1.3 克隆仓库](#2313-克隆仓库)
      - [2.3.1.5 脚本自动完成的操作](#2315-脚本自动完成的操作)
      - [2.3.1.6 密码设置提示](#2316-密码设置提示)
      - [2.3.1.7 磁盘布局](#2317-磁盘布局)
    - [2.3.2 模式 2: Apply Host Configuration — 应用主机 Flake 配置](#232-模式-2-apply-host-configuration--应用主机-flake-配置)
      - [2.3.2.1 克隆并运行配置脚本](#2321-克隆并运行配置脚本)
      - [2.3.2.2 自定义建议](#2322-自定义建议)
      - [2.3.2.3 脚本自动完成的操作](#2323-脚本自动完成的操作)
    - [2.3.3 模式 3: Apply User Configuration — 应用 Home Manager 用户配置](#233-模式-3-apply-user-configuration--应用-home-manager-用户配置)
      - [2.3.3.1 克隆并运行配置脚本](#2331-克隆并运行配置脚本)
      - [2.3.3.2 自定义建议](#2332-自定义建议)
      - [2.3.3.3 脚本自动完成的操作](#2333-脚本自动完成的操作)

---

## 1. 脚本概览

`scripts/` 目录下提供了一些实用脚本，方便日常操作与系统维护：

| 脚本                             | 用途               | 说明                                          |
| -------------------------------- | ------------------ | --------------------------------------------- |
| [`installer.sh`](./installer.sh) | 统一安装与配置脚本 | 覆盖从磁盘分区安装到主机/用户配置应用的全流程 |

> **💡 提示**：
> `functions/` 下的脚本为其他脚本的内部依赖，通常情况下你只需要直接运行 ``scripts/` 目录下的脚本即可

---

## 2. 安装脚本 (installer.sh)

### 2.1 脚本总览

本项目提供一个 **统一安装脚本** `scripts/installer.sh`，覆盖从全新系统安装到用户级配置的完整流程，脚本启动后会显示交互式菜单，选择对应的模式编号即可进入对应操作流程：

| 模式 | 使用场景                    | 运行方式                                 | 说明                                                                |
| ---- | --------------------------- | ---------------------------------------- | ------------------------------------------------------------------- |
| `1`  | 全新系统安装（LiveCD 环境） | `bash scripts/installer.sh` → 选择模式 1 | 磁盘分区 + 系统安装                                                 |
| `2`  | 已安装系统上应用主机配置    | `bash scripts/installer.sh` → 选择模式 2 | 选择主机 + 重建系统，详见 🖥️ [主机管理](../outputs/nixos/README.md) |
| `3`  | 应用 Home Manager 用户配置  | `bash scripts/installer.sh` → 选择模式 3 | 选择用户 + 应用配置，详见 👤 [用户管理](../outputs/home/README.md)  |

---

### 2.2 硬件要求

在开始安装之前，请确保你的硬件满足以下最低要求：

| 配置         | 最低   | 推荐               |
| ------------ | ------ | ------------------ |
| CPU          | 2 核心 | 8 核心             |
| 内存         | 2 GB   | 8 GB (1 核心/1 GB) |
| 硬盘(无桌面) | 10 GB  | 20 GB 以上         |
| 硬盘(有桌面) | 25 GB  | 50 GB 以上         |

> **💡 提示**
> NixOS 的构建过程会消耗较多内存和 CPU 资源
> 如果计划进行大量编译或使用图形界面环境，建议使用推荐配置

---

### 2.3 脚本详细说明

#### 2.3.1 模式 1: LiveCD Install — LiveCD 环境下的全量安装

本阶段将在 NixOS LiveCD 环境中完成系统的基础安装，包括磁盘分区、格式化和系统安装。

##### 2.3.1.1 环境准备

###### 步骤 1：下载 NixOS 镜像

访问 [NixOS 官方下载页面](https://nixos.org/download/) 下载最新的 LiveCD 镜像：

- **推荐版本**：NixOS 25.11 或更新版本
- **镜像类型**：选择不带图形界面的 ISO（约 1GB+）

###### 步骤 2：制作启动盘

使用以下工具之一将镜像写入 U 盘（**至少 2GB**）：

| 工具           | 平台        | 特点                   |
| -------------- | ----------- | ---------------------- |
| Ventoy（推荐） | 跨平台      | 直接拷贝 ISO 文件即可  |
| Rufus          | Windows     | 功能强大，支持多种格式 |
| Etcher         | 跨平台      | 简单易用，图形化界面   |
| dd             | Linux/macOS | 命令行方式             |

##### 2.3.1.2 连接网络

LiveCD 环境启动后，首先需要确保网络连接正常。

###### 有线网络（自动连接）

大多数情况下，插入网线后会自动获取 IP 地址。验证连接：

```bash
# 测试网络连通性
ping -c 3 8.8.8.8
```

###### 无线网络（WiFi）

如果需要使用 WiFi，使用 `nmtui` 图形化工具配置：

```bash
# 启动 NetworkManager TUI
nmtui
```

> **💡 提示**：
> LiveCD 安装脚本使用国内镜像源（上海交大、中科大、清华大学）
> 只需确保国内网络连接即可，无需访问外网

##### 2.3.1.3 克隆仓库

网络连接成功后，克隆本项目到本地：

```bash
# 切换到 root 用户
sudo -i

# 方式一：GitHub 源（推荐）
git clone https://github.com/nix-config/nix-config.git

# 方式二：Gitee 源（国内加速）
git clone https://gitee.com/nix-config/nix-config.git

# 进入仓库根目录
cd nix-config/

# 运行安装脚本, 选择模式 1
bash scripts/installer.sh
# 在菜单中选择 [1] LiveCD Install
```

##### 2.3.1.5 脚本自动完成的操作

| 操作内容            | 详细说明                                                                                           |
| ------------------- | -------------------------------------------------------------------------------------------------- |
| **检测磁盘设备**    | 使用 `lsblk` 列出所有可用磁盘                                                                      |
| **交互式选择磁盘**  | 让你选择要安装的目标磁盘（**⚠️ 此操作将清除该磁盘所有数据**）                                      |
| **卸载已挂载分区**  | 自动检测并卸载目标磁盘上已挂载的分区                                                               |
| **使用 Disko 分区** | 调用 [`disk-config.nix`](./modules/disk-config.nix) 定义的布局进行分区、格式化和挂载               |
| **生成基础配置**    | 运行 `nixos-generate-config` 生成 `hardware-configuration.nix`                                     |
| **复制额外配置**    | 将 [`extra-configuration.nix`](./modules/extra-configuration.nix) 复制到目标系统                   |
| **集成额外配置**    | 自动修改 `configuration.nix` 以引用 [`extra-configuration.nix`](./modules/extra-configuration.nix) |
| **安装系统**        | 运行 `nixos-install` 将系统安装到目标磁盘                                                          |

##### 2.3.1.6 密码设置提示

安装过程中会提示你设置 root 密码：

```bash
setting password...
New password:
Retype new password:
```

> **💡 提示**：
> 通常此处设置的密码是**临时密码**，仅用于首次登录
> 但实际上重启后系统将使用 [extra-configuration.nix](./modules/extra-configuration.nix) 中声明的哈希密码

---

##### 2.3.1.7 磁盘布局

本项目默认使用 Btrfs 文件系统配合 Disko 进行声明式磁盘管理。

**默认 Btrfs 方案**：

默认方案采用 **Btrfs + 子卷** 的设计，具有以下优势：

- **快照支持**：可以轻松创建系统快照用于备份和回滚
- **压缩存储**：使用 Zstd 压缩算法节省磁盘空间
- **CoW（写时复制）**：高效的文件写入性能
- **灵活的子卷组织**：逻辑分离不同用途的数据

**分区表结构**：

默认分区表采用 GPT 格式，包含两个主要分区：

| 分区 | 大小     | 文件系统 | 类型代码 | 挂载点 | 用途         |
| ---- | -------- | -------- | -------- | ------ | ------------ |
| ESP  | 1 GB     | vfat     | EF00     | /boot  | EFI 系统分区 |
| root | 剩余空间 | btrfs    | -        | /      | 根文件系统   |

**Btrfs 子卷结构**：

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

**如何修改默认布局**：

如需自定义磁盘布局，编辑 [disk-config.nix](./modules/disk-config.nix) 文件。

> **💡 提示**：
> 如果已经运行 `scripts/installer.sh` 完成安装修改磁盘布局后，需要重新运行安装脚本才能生效
> 运行前请务必备份重要数据

---

#### 2.3.2 模式 2: Apply Host Configuration — 应用主机 Flake 配置

LiveCD 安装完成后，重启进入新安装的系统，使用此脚本完成最终的主机配置初始化。

##### 2.3.2.1 克隆并运行配置脚本

安装完成后，移除 U 盘并重启系统：

首次登录信息：

| 项目       | 值                        |
| ---------- | ------------------------- |
| **用户名** | `admin`（推荐） 或 `root` |
| **密码**   | `passwd`                  |

登录系统后，再次克隆仓库并运行脚本：

```bash
# 克隆仓库
git clone https://github.com/nix-config/nix-config.git
# 或使用 Gitee
git clone https://gitee.com/nix-config/nix-config.git

# 进入仓库根目录
cd nix-config/

# 运行安装脚本, 选择模式 2
bash scripts/installer.sh
# 在菜单中选择 [2] Apply Host Configuration
```

> **💡 提示**：
> 如果使用非 root 账户，不要使用 sudo 运行此脚本

##### 2.3.2.2 自定义建议

运行脚本前，强烈建议进行以下自定义操作：

###### 创建个人分支

```bash
# 创建并切换到自己的分支
git checkout -b <branch>
```

###### 配置主机

参考 🖥️ [主机管理](../outputs/nixos/README.md) 添加新的主机。

编辑主机配置文件来更改所需模块：

```bash
# 编辑主机选项
nano outputs/nixos/<host>/opts.nix
```

##### 2.3.2.3 脚本自动完成的操作

| 操作内容             | 详细说明                                                                  |
| -------------------- | ------------------------------------------------------------------------- |
| **选择要输出的主机** | 扫描 `outputs/nixos/` 目录的主机并生成选择列表                            |
| **生成默认配置**     | 使用 `sudo nixos-generate-config` 在 `/etc/nixos/` 生成默认配置           |
| **复制硬件配置**     | 将 `/etc/nixos/hardware-configuration.nix` 复制到 `outputs/nixos/<host>/` |
| **暂存更改**         | 将所有文件在 Git 中暂存                                                   |
| **重建系统**         | 使用 `nh os switch .#<host> --ask --max-jobs 1` 应用 flake 配置           |

---

#### 2.3.3 模式 3: Apply User Configuration — 应用 Home Manager 用户配置

该脚本用于在已安装 NixOS 的系统或其他 Linux 发行版上应用 **Home Manager 用户级配置**，实现个人环境的声明式管理。

##### 2.3.3.1 克隆并运行配置脚本

```bash
# 克隆仓库
git clone https://github.com/nix-config/nix-config.git
# 或使用 Gitee
git clone https://gitee.com/nix-config/nix-config.git

# 进入仓库根目录
cd nix-config/

# 运行安装脚本, 选择模式 3
bash scripts/installer.sh
# 在菜单中选择 [3] Apply User Configuration
```

##### 2.3.3.2 自定义建议

运行脚本前，强烈建议进行以下自定义操作：

###### 创建个人分支

```bash
# 创建并切换到自己的分支
git checkout -b <branch>
```

###### 配置用户

参考 👤 [用户管理](../outputs/home/README.md) 添加新的用户。

编辑用户配置文件来更改所需模块：

```bash
# 编辑用户选项
nano outputs/home/<user>/opts.nix
```

##### 2.3.3.3 脚本自动完成的操作

| 操作内容             | 详细说明                                                             |
| -------------------- | -------------------------------------------------------------------- |
| **选择要输出的用户** | 扫描 `outputs/home/` 目录的用户并生成选择列表                        |
| **暂存更改**         | 将所有文件在 Git 中暂存                                              |
| **应用配置**         | 使用 `nh home switch . -c <user> --ask --max-jobs 1` 应用 flake 配置 |

---

<div align="center">

### 祝你安装顺利！🎉

如有问题，欢迎查阅 ❓ [常见问题](../docs/faq.md) 或提交 Issue

</div>

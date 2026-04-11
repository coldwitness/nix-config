# ⚙️ 模块管理

[⬅️ 返回主文档](../README.md)

---

## 📑 目录

- [1. 目录结构概览](#1-目录结构概览)
- [2. 模块分类说明](#2-模块分类说明)
- [3. 如何开发新模块](#3-如何开发新模块)

---

## 1. 目录结构概览

**模块（Module）** 是 NixOS 配置框架的核心构建单元，采用**双层架构**设计：

| 层级     | 说明                                 | 作用域                  |
| -------- | ------------------------------------ | ----------------------- |
| 系统模块 | `modules/` 下的各子目录              | NixOS 系统级配置        |
| 用户模块 | `modules/home/modules/` 下的各子目录 | Home Manager 用户级配置 |

> **💡 关于 `home/config/`**：该目录用于存放需要频繁修改的或 API 未稳定的配置文件。可以在模块软链接这些文件。

---

## 2. 模块分类说明

### 系统模块（NixOS Module）

位于 `modules/` 根目录下，负责系统级基础设施配置：

| 分类     | 路径         | 说明                            |
| -------- | ------------ | ------------------------------- |
| CLI 工具 | `cli/`       | 命令行工具相关系统配置          |
| 容器管理 | `container/` | 容器运行时与管理界面            |
| 桌面环境 | `desktop/`   | 显示服务器与桌面合成器          |
| 硬件配置 | `hardware/`  | GPU、蓝牙、网络、引导等硬件支持 |
| 国际化   | `i18n/`      | 语言本地化与输入法框架          |
| 系统服务 | `service/`   | SSH、Nginx、FRP、网络代理等服务 |
| 实用工具 | `tool/`      | 代理客户端等系统级辅助工具      |

### 用户模块（Home Manager Module）

位于 `modules/home/modules/` 下，负责用户空间应用程序配置：

| 分类       | 路径        | 说明                         |
| ---------- | ----------- | ---------------------------- |
| CLI 工具   | `cli/`      | 终端增强工具与开发效率工具   |
| 桌面环境   | `desktop/`  | 桌面主题与窗口管理器用户配置 |
| 编辑器     | `editor/`   | 文本编辑器与 IDE 配置        |
| 网络应用   | `internet/` | 浏览器与即时通讯软件         |
| 媒体应用   | `media/`    | 视频播放器与流媒体客户端     |
| Shell      | `shell/`    | 交互式命令行 shell 配置      |
| 终端模拟器 | `terminal/` | 终端仿真器配置               |
| 实用工具   | `tool/`     | 输入法、游戏平台、办公套件等 |

---

## 3. 如何开发新模块

创建新模块仅需 **2 步**，无需修改任何其他文件：

```bash
# 在对应分类目录下创建 .nix 文件
touch modules/hardware/my-module.nix          # 系统模块示例
touch modules/home/modules/cli/my-module.nix  # 用户模块示例

# 编写模块内容
nano modules/hardware/my-module.nix
nano modules/home/modules/cli/my-module.nix
```

**标准模板**：

```nix
{
  lib,
  opts,
  ...
}:
let
  cfg = opts.<分类>.<模块名> or { };
  finallyEnable = cfg.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    # 在此编写配置
  };
}
```

> **💡 自动发现机制**：`default.nix` 通过 `importSubdirModules` 自动递归扫描子目录，
> 新建的 `.nix` 模块文件会被自动识别并导入，无需手动注册！

**无需做的操作** ❌：

- ~~修改 `default.nix`~~ — 自动扫描子目录，无需手动注册
- ~~修改 Flake 入口~~ — 无需在顶层声明新模块
- ~~修改其他任何文件~~ — 只需关注你的 `.nix` 模块文件本身

---

<div align="center">

### 开始构建你的模块吧！🚀

如有问题，欢迎查阅 [常见问题](../docs/faq.md) 或提交 Issue

</div>

<div align="center">

# ✨ 适用于任何场景的 Nix 配置框架实现

细粒度 · 高隔离 · 松耦合 · 多模式

![桌面截图](https://picui.ogmua.cn/s1/2026/04/01/69ccf0a37b909.webp)

</div>

## 📑 文档索引

| 文档                                         | 内容                         | 作用                               |
| -------------------------------------------- | ---------------------------- | ---------------------------------- |
| 📜 [脚本指南](./scripts/README.md)           | 实用脚本的使用介绍           | 一些包含安装等功能的一键脚本       |
| 🖥️ [主机管理](./outputs/nixos/README.md)     | 增删改查主机配置             | 配置主机输出                       |
| 👤 [用户管理](./outputs/home/README.md)      | 增删改查用户配置             | 配置用户输出                       |
| 🧩 [选项集管理](./outputs/optSets/README.md) | 增删改查选项集               | 方便复用与减少样板代码的组合式选项 |
| ⚙️ [模块管理](./modules/README.md)           | 增删改查 nix 模块            | 决定系统及软件行为的配置           |
| ❓ [常见问题](./docs/faq.md)                 | 故障排查                     | 常见错误速查                       |
| 🏗️ [架构概览](./docs/architecture.md)        | 设计理念                     | 了解由设计理念衍生出的整体架构     |
| 🗺️ [未来计划](./docs/roadmap.md)             | 未来可能实现的一些功能和优化 | 可供参考的未来计划                 |

---

## 📂 目录结构

```bash
.
├── functions/                                  # 工具函数
├── modules/                                    # 模块
│   ├──config/                                  # 原生配置文件
│   ├──darwin/                                  # darwin 模块
│   │  └──<category>/                           # 模块分类
│   ├──home/                                    # home 模块
│   │  └──<category>/                           # 模块分类
│   └──nixos/                                   # nixos 模块
│      └──<category>/                           # 模块分类
├── outputs/                                    # Flake 输出
│   ├── home/                                   # 用户
│   │   └── <user>/                             # 具体用户
│   │       └── opts.nix                        # 用户选项定义
│   ├── nixos/                                  # 主机
│   │   └── <host>/                             # 具体主机
│   │       ├── hardware-configuration.nix      # 主机硬件配置
│   │       └── opts.nix                        # 主机选项定义
│   └── optSets/                                # 选项集
├── scripts/                                    # 工具脚本
├── secrets/                                    # 私密文件
├── vars/                                       # 公共变量
├── .sops.yaml                                  # sops 配置
├── flake.lock                                  # Flake 版本锁
├── flake.nix                                   # Flake 输入
└── justfile                                    # 快捷命令
```

---

## 🔗 相关资源

- [NixOS 官方文档](https://nixos.org/manual/nixos/stable/)
- [Disko 文档](https://github.com/nix-community/disko)
- [Home Manager 文档](https://nix-community.github.io/home-manager/)
- [Nix Flakes 文档](https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-flake)

---

<div align="center">

[![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/nix-config/nix-config)

</div>

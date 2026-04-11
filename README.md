<div align="center">

# ✨ 适用于任何场景的 Nix 配置框架实现

细粒度控制 · 松耦合 · 多模式输出 · 自动模块发现

![桌面截图](https://picui.ogmua.cn/s1/2026/04/01/69ccf0a37b909.webp)

## </div>

## 📑 文档索引

| 文档                                         | 内容                     |
| -------------------------------------------- | ------------------------ |
| 📦 [安装指南](./scripts/installer/README.md) | 安装及初始化             |
| 🖥️ [主机管理](./outputs/hosts/README.md)     | 添加主机、修改主机配置   |
| 👤 [用户管理](./outputs/users/README.md)     | 添加用户、修改用户配置   |
| 🧩 [选项集管理](./outputs/optSets/README.md) | 组合式抽象、减少样板代码 |
| ⚙️ [模块开发](./modules/README.md)           | 自定义模块               |
| ❓ [常见问题](./docs/faq.md)                 | 故障排查                 |
| 🏗️ [架构概览](./docs/architecture.md)        | 设计理念                 |
| 🗺️ [未来计划](./docs/roadmap.md)             | 未来规划参考             |

---

## 📂 目录结构

```bash
.
├── outputs/                                    # Flake 输出
│   ├── <platform>/                             # 系统架构
│   │   └── hosts/                              # 主机
│   │       └── <host>/                         # 具体主机
│   │           ├── default.nix                 # 主机输出入口
│   │           ├── opts.nix                    # 主机选项定义
│   │           └── hardware-configuration.nix  # 主机硬件配置
│   └── users/                                  # 用户
│       └── <user>/                             # 具体用户
│           ├── default.nix                     # 用户输出入口
│           └── opts.nix                        # 用户选项定义
├── modules/                                    # 系统模块
│   ├──<category>/                              # 模块分类
│   └──home/
│      ├──modules/                              # 用户模块
│      │  └──<category>/
│      └──config/                               # 原生配置文件
├── vars/                                       # 公共变量
├── functions/                                  # 工具函数
├── secrets/                                    # 私密信息(采用子模块)
├── scripts/                                    # 工具脚本
├── flake.nix                                   # Flake 输入
├── flake.lock                                  # Flake 版本锁
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

# 🖥️ 主机管理

[⬅️ 返回主文档](../../README.md)

---

## 📑 目录

- [1. 添加新主机](#1-添加新主机)
- [2. 配置文件说明](#2-配置文件说明)

---

## 1. 添加新主机

添加新主机仅需 **3 步**，无需修改任何其他文件：

```bash
# 复制模板文件夹
cp -r outputs/hosts/x86_64-linux/default-x86-64/ outputs/hosts/x86_64-linux/<host-name>/

# 编辑选项
nano outputs/hosts/x86_64-linux/<host-name>/opts.nix

# 执行安装脚本
cd scripts/installer/
sudo bash installer.sh
# 选择对应的主机名即可自动应用配置
```

详情请见：[安装指南](../../scripts/installer/README.md)

**无需做的操作** ❌：

- ~~修改 `default.nix`~~ — 自动扫描，无需手动注册
- ~~修改 Flake 入口~~ — 无需在顶层声明新主机
- ~~创建其他配置文件~~ — 只需关注 `opts.nix`

> **💡 核心优势**：系统采用零注册设计——文件夹名称即为主机名，
> 放入即生效，无需修改任何其他文件！
> 可通过引用 [outputs/optSets/](../optSets/) 中的预定义模板。

---

## 2. 配置文件说明

每个主机目录包含两个核心文件：

| 文件                                                     | 说明                                                               |
| -------------------------------------------------------- | ------------------------------------------------------------------ |
| [default.nix](./x86_64-linux/default-x86-64/default.nix) | NixOS 模块入口，组装模块并生成 `nixosConfigurations`，通常无需修改 |
| [opts.nix](./x86_64-linux/default-x86-64/opts.nix)       | **主机选项配置**，控制所有功能模块的开关和参数                     |

建议按以下方式查阅：

```bash
# 查看 default-x86-64/ 模板获取最完整的选项列表和注释
cat outputs/hosts/x86_64-linux/default-x86-64/opts.nix
```

---

<div align="center">

### 开始配置你的第一台主机吧！🚀

如有问题，欢迎查阅 [常见问题](../../docs/faq.md) 或提交 Issue

</div>

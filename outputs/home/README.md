# 👤 用户管理

[⬅️ 返回主文档](../../README.md)

---

## 📑 目录

- [1. 添加新用户](#1-添加新用户)
- [2. 配置文件说明](#2-配置文件说明)

---

## 1. 添加新用户

添加新用户仅需 **3 步**，无需修改任何其他文件：

```bash
# 复制模板文件夹
cp -r outputs/users/default outputs/users/<user-name>

# 编辑选项
nano outputs/users/<user-name>/opts.nix

# 执行安装脚本
cd scripts/installer/
bash user-installer.sh
# 选择对应的用户名和平台即可自动应用配置
```

安装脚本详情请见：[安装指南](../../scripts/installer/README.md#333-脚本自动完成的操作)

**无需做的操作** ❌：

- ~~修改 `default.nix`~~ — 自动扫描，无需手动注册
- ~~修改 Flake 入口~~ — 无需在顶层声明新主机
- ~~创建其他配置文件~~ — 只需关注 `opts.nix`

> **💡 核心优势**：系统采用零注册设计——文件夹名称即为用户名，
> 放入即生效，无需修改任何其他文件！
> 可通过引用 [选项集管理](../optSets/README.md) 中的预定义模板。

---

## 2. 配置文件说明

每个用户目录包含两个核心文件：

| 文件                                 | 说明                                                                                           |
| ------------------------------------ | ---------------------------------------------------------------------------------------------- |
| [default.nix](./default/default.nix) | Home Manager 模块入口，定义用户基本信息（username、homeDirectory、stateVersion），无需手动修改 |
| [opts.nix](./default/opts.nix)       | **用户选项配置**，控制所有功能模块的开关和参数                                                 |

建议按以下方式查阅：

```bash
# 查看 default/ 模板获取最完整的选项列表和注释
cat outputs/users/default/opts.nix
```

<div align="center">

### 开始定制你的用户环境吧！🚀

如有问题，欢迎查阅 [常见问题](../../docs/faq.md) 或提交 Issue

</div>

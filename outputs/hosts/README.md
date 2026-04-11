# 🖥️ 主机管理

[⬅️ 返回主文档](../../README.md)

---

## 📑 目录

- [1. 添加新主机](#1-添加新主机)
- [2. 配置文件说明](#2-配置文件说明)
- [3. 多实例输出模式](#3-多实例输出模式)

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
> 可通过引用 [选项集管理](../optSets/README.md) 中的预定义模板。

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

## 3. 多实例输出模式

当需要管理大量**配置相同、仅主机名不同**的机器时（如企业办公同质化部署），可以使用多实例输出模式，一次定义即可批量生成多台主机的配置。

### 启用方式

编辑目标主机目录下的 [default.nix](./x86_64-linux/default-x86-64/default.nix)，修改内部变量 `count`：

```nix
let
  count = 5;  # 生成 5 个实例
in ...
```

| `count` 值  | 行为                                                               |
| ----------- | ------------------------------------------------------------------ |
| `1`（默认） | 单机模式，生成一个以目录名为名称的配置，行为与不使用该功能完全一致 |
| `N` (>1)    | 批量模式，生成 N 个配置，命名格式为 `${目录名}-${序号}`            |

### 命名规则

批量生成的实例自动按以下规则命名：

- 格式：`${目录名}-${序号}`
- 序号范围：`1` ~ `N`
- 示例：目录名 `default-x86-64`，count 为 `5` 时 → `default-x86-64-1` ~ `default-x86-64-5`

每个实例独立加载 `opts.nix` 并传入各自对应的 `hostName`，确保网络配置等依赖主机名的模块正确工作。

### 输出示例

将 `count` 设为 `5` 后，执行 `nix flake show` 将看到：

```bash
nix flake show
.
└───nixosConfigurations
    ├───default-aarch64: NixOS configuration
    ├───default-i686: NixOS configuration
    ├───default-x86_64-1: NixOS configuration
    ├───default-x86_64-2: NixOS configuration
    ├───default-x86_64-3: NixOS configuration
    ├───default-x86_64-4: NixOS configuration
    └───default-x86_64-5: NixOS configuration
```

> **💡 提示**：此功能仅修改单个主机目录的 `default.nix` 内部变量，
> 不影响其他主机目录，也无需改动调用方代码。

---

<div align="center">

### 开始配置你的第一台主机吧！🚀

如有问题，欢迎查阅 [常见问题](../../docs/faq.md) 或提交 Issue

</div>

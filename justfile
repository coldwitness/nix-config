# 查看输出
show:
    nix flake show .

# 构建系统
os *args:
    nh os switch . --ask {{args}}

# 构建用户
home *args:
    nh home switch . --ask {{args}}

# 更新锁文件
update *args:
    nix flake update {{args}}

# 清理
clean *args:
    nh clean all --ask {{args}}

# 格式化 nix 文件
fmt:
    treefmt .

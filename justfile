# 重建系统
rebuild *args:
    nh os switch . --ask {{args}}

# 重建用户
home rebuild name platform *args:
    nh home switch .#{{name}}-{{platform}} --ask {{args}}

# 更新并重建系统
update *args:
    nh os switch . --ask --update {{args}}

# 清理系统
clean *args:
    nh clean all --ask {{args}}

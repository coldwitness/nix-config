# 重建系统
rebuild *args:
    nh os switch . --ask {{args}}

# 更新并重建系统
update *args:
    nh os switch . --ask --update {{args}}

# 清理系统
clean *args:
    nh clean all --ask {{args}}

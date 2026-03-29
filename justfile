# 重建系统
rebuild:
    nh os switch . --ask

# 更新并重建系统
update:
    nh os switch . --ask --update

# 清理系统
clean:
    nh clean all

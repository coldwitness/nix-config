# 忽略问候
set -g fish_greeting

# 启用 fzf
fzf --fish | source

# 启用 starship
starship init fish | source

function nhm
    set -l choice (printf "1: 重建\n2: 更新\n3: 清理" | fzf --prompt="选择操作: " --height=7 --border)
    switch "$choice"
        case "1: 重建"
            nh os switch --ask
        case "2: 更新"
            nh os switch --ask --update
        case "3: 清理"
            nh clean all
        case '*'
            echo "操作已取消"
    end
end

# 命令替换
alias cat "bat"
alias top "btop"
alias ls "eza --icons --git"
alias tree "eza --icons --git -T"

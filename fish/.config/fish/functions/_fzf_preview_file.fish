function _fzf_comprun
    set command $argv[1]
    switch "$command"
        case 'cd'
            fzf --preview 'eza --tree --color=always {} | head -200' $argv
        case 'export' 'unset'
            fzf --preview "eval 'echo $"$argv
        case 'ssh'
            fzf --preview 'dig {}' $argv
        case '*'
            fzf --preview "bat -n --color=always --line-range :500 {}" $argv
    end
end


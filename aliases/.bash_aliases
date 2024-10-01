# ~/aliases.sh

# Fuzzy Search Through Command History 
alias fh='eval $(history | fzf | cut -d " " -f 4-)'

# Fuzzy Search Through Files in a Directory
alias ff='find . -type f | fzf'

# Search and Open Files with Custom Commands (e.g., vim)
alias fvim='find . -type f | fzf | xargs -r nvim'

# Fuzzy Grep Search
alias fg='grep -r "search_term" . | fzf'

# Switch to Recent Directories
alias fd='dirs -v | fzf | awk "{print \$2}" | xargs -r cd'

# Kill Processes Using fzf
alias fk='ps aux | fzf | awk "{print \$2}" | xargs -r kill'

# Fuzzy Git Branch Switching
alias fb='git branch | fzf | xargs -r git checkout'

# Search Environment Variables
alias fe='printenv | fzf'

# Search Through Aliases
alias fa='alias | fzf'

# Fuzzy SSH Host Selector
alias fssh='grep "^Host " ~/.ssh/config | awk "{print \$2}" | fzf | xargs -r ssh'

# Fuzzy Directory Navigation
alias fdn='find . -type d | fzf | xargs -r cd'

# Search Installed Packages
alias fpkg='dpkg --list | fzf'

# Preview JSON Files
alias fj='bat some_file.json | jq . | fzf'

# Browse Git Commits
alias fc='git log --oneline | fzf | awk "{print \$1}" | xargs -r git show'

# Quick Search Through System Logs
alias fsyslog='journalctl | fzf'

# Interactive Package Removal
alias fremove='dpkg --list | fzf | awk "{print \$2}" | xargs -r sudo apt remove'

# Fuzzy Search for Recent Files Accessed
alias fr='ls -ltu | fzf'

# Fuzzy Search for Recently Modified Files
# alias fm='find . -type f -printf "%T@ %p\n" | sort -n | fzf | awk '{print $2}' | xargs -r vim'

# Fuzzy Search Through Processes
alias fps='ps aux | fzf --preview "echo {} | awk '\''{print \$1, \$11}'\''"'

# Fuzzy Search and Kill Processes
alias fkill='ps aux | fzf --preview "echo {} | awk '\''{print \$1, \$2, \$11}'\''" | awk "{print \$2}" | xargs -r kill'

# Fuzzy Search for Recent Commands
alias frc='fc -l | fzf'

# Fuzzy Search Through Systemd Units
alias fsystemd='systemctl list-units --type=service | fzf'

# Fuzzy Search Through Cron Jobs
alias fcron='crontab -l | fzf'

# Fuzzy Search and Open Files with Preview
# alias fopen='find . -type f | fzf --preview "bat {} | head -100" | xargs -r vim'

# Fuzzy Search Through Docker Containers
alias fdocker='docker ps -a | fzf --preview "docker inspect {} | jq .[0].State.Status"'

# Fuzzy Search for Git Tags
alias ft='git tag | fzf | xargs -r git show'

# ---------------------------others-------------------------------------


# Create a new directory and navigate into it
alias mkcd='foo(){ mkdir -p "$1" && cd "$1"; }; foo'

# Display disk usage in a human-readable format
alias du='du -h'

# Show disk space usage of the file system
alias df='df -h'

# Show system's top processes by CPU usage
alias top='btop'

# Show running processes with a tree view
alias pstree='pstree -p'

# Search for a string in a file with case insensitivity
alias grep='grep -i'

# Show network connections and listening ports
alias netstat='netstat -tuln'

# Show IP address of your machine
alias ip='ip addr show'

# Show the git status and display differences in a colorized format
alias gst='git status'
alias gdiff='git diff --color=auto'

# Search through command history with fzf
alias h='history | fzf'

# Check for any available updates on Debian-based systems
alias update='sudo nala update && sudo nala upgrade'

# Check and repair file system (requires sudo)
alias fsck='sudo fsck'

#show all symlinks in current directory
alias sl='ls -l -a   | grep "\->"'

# Print the current system uptime
alias uptime='uptime -p'

# Print the current date and time in a human-readable format
alias datetime='date "+%Y-%m-%d %H:%M:%S"'

# show sesh tmux sessions
alias seshi='sesh list -i'
alias sesht='sesh list -it'
alias seshc='sesh list -ic'
alias seshz='sesh list -iz'



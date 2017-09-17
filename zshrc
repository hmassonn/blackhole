alias mysql='~/http/bin/mysql'
alias valgrind="~/.brew/bin/valgrind"

# Load Homebrew config script
source $HOME/.brewconfig.zsh


while true; do leaks minishell | grep “leak for”; done

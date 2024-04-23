#!/bin/ksh
#-*-Shell-script-*-

# Ksh Shell Configuration
HISTFIL="$HOME/.ksh_history"
HISTSIZE=5000

alias ..="cd .."
alias ...="cd ../../"
alias cd=_cd
alias readme='readme() { local file=${1:-README.md}; lowdown -T term "$file" | less -R; }; readme'


alias bucknell='doas wpa_supplicant -c /etc/wpa_supplicant.conf -i iwm0 &'
alias python='python3'
alias rm='rm -rvf '

# Define the prefix and suffix for the git prompt.
GIT_PROMPT_PREFIX="git:"
GIT_PROMPT_SUFFIX=""

# Set the characters to use for the dirty and clean git prompt indicators.
GIT_PROMPT_DIRTY="*"
GIT_PROMPT_CLEAN=""

# Shortened current directory for the prompt.
_cd () {
    # Takes one or more arguments that are passed into the cd command. 
    "cd" "$@"

    # If the current working directory starts with the home directory and is not the root directory (/),
    # set the _pwd variable to a tilde (~) followed by the current working directory with the home directory removed. 
    if [[ $PWD = $HOME* && $HOME != / ]]; then
        _pwd=\~${PWD#$HOME}
        return
    fi
    
    # If the current working directory does not start with the home directory, 
    # set the _pwd variable to the current working directory.
    _pwd="$PWD"
}
_cd .

# Define a function to display the git prompt info.
git_prompt_info() {
  # Check if the current directory is a git repository.
    if git rev-parse --git-dir > /dev/null 2>&1; then
        # Get the current branch name.
        local branch=$(git symbolic-ref --short HEAD)

    # Check if the repository has any unstaged changes.
    if [[ -n $(git diff --shortstat 2> /dev/null | tail -n1) ]]; then
        # The repository has unstaged changes, so set the dirty indicator.
        local dirty=$GIT_PROMPT_DIRTY
    else
        # The repository has no unstaged changes, so set the clean indicator.
        local dirty=$GIT_PROMPT_CLEAN
    fi

        # Return the git prompt info in the desired format.
        printf "$GIT_PROMPT_PREFIX$branch$dirty$GIT_PROMPT_SUFFIX"
    fi
}

# Primary prompt which is displayed before each command.
PS1='$(printf "%*s\r%s" $(( COLUMNS-1 )) "$(git_prompt_info)" "$_pwd $ ")'

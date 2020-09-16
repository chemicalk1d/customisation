
#start the ssh-agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1d > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi


if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi


if [ $(ssh-add -l | grep -v 'The agent has no identities.' | wc -l) -eq 0 ]; then
    #add all private keys in .ssh to the ssh-agent by default
    file ~/.ssh/* | grep 'private key' | cut -d ':' -f 1 | xargs ssh-add &>/dev/null
fi

#my aliases
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip --color=auto'
alias ls='ls -lh --color=auto'
alias less='less -r'
alias dmesg='dmesg --color=always'
alias du='du -h'
alias nc='ncat'

#git bash autocomplete
source /usr/share/git/completion/git-completion.bash

#source my bash prompt which is in a seperate file
source $HOME/.prompt

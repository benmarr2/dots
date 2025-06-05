#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

. "$HOME/.cargo/env"

export PATH="~/.local/bin:$PATH"

if [ -f `which powerline-daemon` ]; then
    powerline-daemon -q
    POWERLINE_BASH_CONTINUATION=1
    POWERLINE_BASH_SELECT=1
fi
if [ -f /usr/local/lib/python3.8/dist-packages/powerline/bindings/bash/powerline.sh ]; then
    source /usr/local/lib/python3.8/dist-packages/powerline/bindings/bash/powerline.sh
fi

export CHATGPT_API_KEY=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

alias notes='lvim ~/vimwiki/ -c "VimwikiIndex"'


alias v="lvim"
alias repos="cd ~/repos/projects/"
eval "$(starship init bash)"

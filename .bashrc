#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias cls='clear'
alias cat='bat'
alias conf='cd ~/.config'
alias ls='ls --color=auto'
alias grep='rg'
alias vi='nvim'
alias tm='tmux'
alias fgj='fg'

alias notes='NVIM_PICKER_PROFILE=terminal nvim --cmd "cd ~/Documents/Notes" -c ObsidianQuickSwitch'
alias new='NVIM_PICKER_PROFILE=terminal nvim --cmd "cd ~/Documents/Notes/05_Templates" -c ObsidianNewFromTemplate'

alias today='nvim -c ObsidianToday'

# General
alias ff='NVIM_PICKER_PROFILE=terminal nvim -c "Telescope find_files theme=ivy"'
alias fg='NVIM_PICKER_PROFILE=terminal nvim -c "Telescope live_grep theme=ivy"'

# Home ~
alias fa='cd ~/ && NVIM_PICKER_PROFILE=terminal nvim -c "Telescope find_files theme=ivy"'
alias ga='cd ~/ && NVIM_PICKER_PROFILE=terminal nvim -c "Telescope live_grep theme=ivy"'

# Repos ~/repos
alias fr='cd ~/repos/ && NVIM_PICKER_PROFILE=terminal nvim -c "Telescope find_files theme=ivy"'
alias gr='cd ~/repos/ && NVIM_PICKER_PROFILE=terminal nvim -c "Telescope live_grep theme=ivy"'

# Config ~/.config
alias fc='cd ~/.config/ && NVIM_PICKER_PROFILE=terminal nvim -c "Telescope find_files theme=ivy"'
alias gc='cd ~/.config/ && NVIM_PICKER_PROFILE=terminal nvim -c "Telescope live_grep theme=ivy"'

# Notes ~/notes
alias fn='cd ~/notes/ && NVIM_PICKER_PROFILE=terminal nvim -c "Telescope find_files theme=ivy"'
alias gn='cd ~/notes/ && NVIM_PICKER_PROFILE=terminal nvim -c "Telescope live_grep theme=ivy"'

PS1='[\u@\h \W]\$ '

# set -o vi

# enable bash completions
if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
fi

export MANPAGER='nvim +Man!'
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export TERM=wezterm
export COLORTERM=truecolor

# eval "$(starship init bash)"
eval "$(oh-my-posh init bash --config gruvbox)"
. "$HOME/.cargo/env"

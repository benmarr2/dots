if status is-interactive
    # Commands to run in interactive sessions can go here
end


# ~/.config/fish/config.fish

# Only run for interactive sessions
if not status --is-interactive
    exit
end

# Aliases
alias cls='clear'
alias cat='bat'
alias conf='cd ~/.config'
alias ls='ls --color=auto'
alias grep='rg'
alias vi='nvim'
alias tm='tmux'
alias fgj='fg'
alias book='zathura'
alias swapesc='setxkbmap -option caps:swapescape'

alias notes='env NVIM_PICKER_PROFILE=terminal nvim --cmd "cd ~/Documents/Notes" -c ObsidianQuickSwitch'
alias new='env NVIM_PICKER_PROFILE=terminal nvim --cmd "cd ~/Documents/Notes/05_Templates" -c ObsidianNewFromTemplate'
alias today='nvim -c ObsidianToday'

# General
alias ff='env NVIM_PICKER_PROFILE=terminal nvim -c "Telescope find_files theme=ivy"'
alias fg='env NVIM_PICKER_PROFILE=terminal nvim -c "Telescope live_grep theme=ivy"'

# Home ~
alias fa='cd ~; env NVIM_PICKER_PROFILE=terminal nvim -c "Telescope find_files theme=ivy"'
alias ga='cd ~; env NVIM_PICKER_PROFILE=terminal nvim -c "Telescope live_grep theme=ivy"'

# Repos ~/repos
alias fr='cd ~/repos; env NVIM_PICKER_PROFILE=terminal nvim -c "Telescope find_files theme=ivy"'
alias gr='cd ~/repos; env NVIM_PICKER_PROFILE=terminal nvim -c "Telescope live_grep theme=ivy"'

# Config ~/.config
alias fc='cd ~/.config; env NVIM_PICKER_PROFILE=terminal nvim -c "Telescope find_files theme=ivy"'
alias gc='cd ~/.config; env NVIM_PICKER_PROFILE=terminal nvim -c "Telescope live_grep theme=ivy"'

# Notes ~/Documents/Notes
alias fn='cd ~/Documents/Notes; env NVIM_PICKER_PROFILE=terminal nvim -c "Telescope find_files theme=ivy"'
alias gn='cd ~/Documents/Notes; env NVIM_PICKER_PROFILE=terminal nvim -c "Telescope live_grep theme=ivy"'

# Prompt
# You’ll replace this with your posh/starship setup below

# Vi mode (optional)
fish_vi_key_bindings

# Environment variables
set -x MANPAGER 'nvim +Man!'
set -Ux PATH $HOME/.local/bin $HOME/.cargo/bin $PATH
set -x COLORTERM truecolor
set -x ELECTRON_OZONE_PLATFORM_HINT auto

# Rust/Cargo in Fish
set -gx CARGO_HOME $HOME/.cargo
set -gx RUSTUP_HOME $HOME/.rustup
fish_add_path $CARGO_HOME/bin


set -U fish_greeting

function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

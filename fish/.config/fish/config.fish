set -g fish_greeting

if status is-interactive
    starship init fish | source
end

# Set up fzf key bindings
fzf --fish | source

# List Directory
alias l='eza -lh  --icons=auto' # long list
alias ls='eza -1   --icons=auto' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs
alias lt='eza --icons=auto --tree' # list folder as tree
alias c="xclip"

# Handy change dir shortcuts
abbr .. 'cd ..'
abbr ... 'cd ../..'
abbr .3 'cd ../../..'
abbr .4 'cd ../../../..'
abbr .5 'cd ../../../../..'

# Always mkdir a path (this doesn't inhibit functionality to make a single dir)
abbr mkdir 'mkdir -p'
fish_vi_key_bindings

alias ls="exa -la --color=always --group-directories-first"
alias vim="nvim"

fish_add_path /home/dunishaaa/.local/bin
fish_add_path /home/dunishaaa/Scripts


#fastfetch

# Devarch - Developer Arch Linux
# =================================

# Starship prompt
eval "$(starship init zsh)"

# Zsh plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Devarch aliases
alias ll='eza -lh --icons --group-directories-first'
alias la='eza -lah --icons --group-directories-first'
alias lt='eza -lT --icons --group-directories-first'
alias cat='bat --paging=never'
alias grep='rg'
alias find='fd'
alias top='btop'
alias du='duf'
alias df='duf'
alias vim='nvim'
alias vi='nvim'
alias please='sudo $(fc -ln -1)'
alias devinstall='archinstall'
alias devarch-update='sudo pacman -Syu && yay -Syu --devel --timeupgrade'
alias ls='eza --icons --group-directories-first'

# Dev tools
export EDITOR=nvim
export VISUAL=nvim
export BROWSER=firefox
export TERMINAL=kitty

# PATH
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

# FZF
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

# Welcome message
fastfetch

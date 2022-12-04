# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd beep extendedglob nomatch notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/dan/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# neofetch

# Source manjaro-zsh-configuration
if [[ -e ~/.zsh-config ]]; then
  source ~/.zsh-config
fi
# Use manjaro zsh prompt
if [[ -e ~/.zsh-prompt ]]; then
  source ~/.zsh-prompt
fi

# Add zoxide 'cd' replacement
eval "$(zoxide init zsh --cmd cd)"

# Add starship prompt
eval "$(starship init zsh)"

# Add required variables for tmuxinator
export EDITOR='nvim'
export PATH="$PATH:$HOME/.local/share/gem/ruby/3.0.0/bin"

#if [[ -z "$TMUX" ]]; then
  #tmux new-session -A -s "$USER"
#fi

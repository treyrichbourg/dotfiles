# Set up the prompt

#autoload -Uz promptinit
#promptinit
#prompt adam1
#prompt="%F{#A89984}%n@%m%F{#EBDBB2}:%B%F{#458588}%~%#%b "
prompt="%F{#A89984}%n@%m%F{#EBDBB2}:%B%F{#458588}%~%b%F{#EBDBB2}%# "


setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Alias
alias ls='ls --color=auto -lh'
alias ll="ls -alh"
alias la='ls -A'
alias l='ls -CF'
alias apti='sudo apt install'
alias aptu='sudo apt update && sudo apt upgrade -y'
alias aptl='apt list --installed'
alias apts='apt search'
alias vim='nvim'
alias vi='nvim'
alias ledg='ledger -f ~/Documents/Adulting/Ledger/ledger.txt'
alias tty-clock='tty-clock -tc'
alias sudo='nocorrect sudo -E '

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

#fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Title Bar
chpwd() {
  [[ -t 1 ]] || return
  case $TERM in
    sun-cmd) print -Pn "\e]l%~\e\\"
      ;;
    *xterm*|rxvt|(dt|k|E)term) print -Pn "\e]2;%~\a"
      ;;
  esac
}

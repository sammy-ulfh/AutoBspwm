# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Created by newuser for 5.9
source /home/sammy/powerlevel10k/powerlevel10k.zsh-theme

# Fix the java Problem
export _JAVA_AWT_WM_NONREPARENTING=1

# ZSH autosuggestions Plugin
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
	source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# ZSH syntax highlighthind Plugin
if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
	source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# ZSH autocomplete Plugin
#if [ -f /usr/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh ]; then
#	source /usr/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
#fi

# ZSH sudo plugin
if [ -f /usr/share/zsh-sudo/sudo.plugin.zsh ]; then
	source /usr/share/zsh-sudo/sudo.plugin.zsh
fi


# Custom aliases
#---------------------------------------

#bat
alias cat='bat'
alias catn='bat --style=plain'
alias catnp='bat --style=plain --paging=never'

#ls
alias ll='lsd -lh --group-dirs=first'
alias la='lsd -la --group-dirs=first'
alias l='lsd --group-dirs=first'
alias lla='lsd -lha --group-dirs=first'
alias ls='lsd --group-dirs=first'

#openApp
alias obsidian='/opt/obsidian/Obsidian.AppImage & disown'

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt histignorealldups sharehistory


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


export LS_COLORS="$(echo $LS_COLORS | sed 's/=01;/=/g')"
export PATH="/opt/obsidian/:/opt/kitty/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/sbin:/opt/nvim/nvim-linux64/bin"

# Custom funstions

# Set Target to hack
function settarget(){
  ip_address=$1
  machine_name=$2
  echo "$ip_address $machine_name" > /home/sammy/.config/bin/target
}

# Clear Target to hack
function cleartarget(){
  echo '' > /home/sammy/.config/bin/target
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

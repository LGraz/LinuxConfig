# source: https://www.youtube.com/watch?v=ud7YxC33Z3w
source ~/.envs_and_aliases


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -e   # emacs-mode
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'


# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"



# ---------- OLD ----------------------------------------
# # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# # Initialization code that may require console input (password prompts, [y/n]
# # confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# # Lines configured by zsh-newuser-install
# HISTFILE=~/.zsh_hist
# HISTSIZE=2000
# SAVEHIST=2000
# set -k # ignore comments in zsh (thing beginning with "#")
# setopt autocd extendedglob nomatch
# unsetopt beep
# # End of lines configured by zsh-newuser-install
# # The following lines were added by compinstall
# zstyle :compinstall filename '/home/lukas/.zshrc'

# autoload -Uz compinit promptinit
# promptinit
# compinit

# zstyle ':completion:*' menu select
# zstyle ':completion::complete:*' gain-privileges 1 # this gives sudo access to completion script

# # End of lines added by compinstall

# source ~/.env_vars
# source ~/.aliases




# # prompt
# 	source ~/powerlevel10k/powerlevel10k.zsh-theme
# 	# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# 	[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# # auto-suggestions
# 	source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# # fuck
# 	eval $(thefuck --alias)




# # the end ----------------------
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# # To customize prompt, run `p10k configure` or edit ~/ArchTitus/configs/config_files/homedir/.p10k.zsh.
# [[ ! -f ~/ArchTitus/configs/config_files/homedir/.p10k.zsh ]] || source ~/ArchTitus/configs/config_files/homedir/.p10k.zsh

# PATH="/home/lukas/perl5/bin${PATH:+:${PATH}}"; export PATH;
# PERL5LIB="/home/lukas/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
# PERL_LOCAL_LIB_ROOT="/home/lukas/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
# PERL_MB_OPT="--install_base \"/home/lukas/perl5\""; export PERL_MB_OPT;
# PERL_MM_OPT="INSTALL_BASE=/home/lukas/perl5"; export PERL_MM_OPT;

# eval "$(zoxide init zsh)"

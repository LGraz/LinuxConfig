# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_hist
HISTSIZE=2000
SAVEHIST=2000
set -k # ignore comments in zsh (thing beginning with "#")
setopt autocd extendedglob nomatch
unsetopt beep
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/lukas/.zshrc'

autoload -Uz compinit promptinit
promptinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1 # this gives sudo access to completion script

# End of lines added by compinstall

source ~/.env_vars
source ~/.aliases




# prompt
	source ~/powerlevel10k/powerlevel10k.zsh-theme
	# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
	[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# auto-suggestions
	source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# fuck
	eval $(thefuck --alias)




# the end ----------------------
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# To customize prompt, run `p10k configure` or edit ~/ArchTitus/configs/config_files/homedir/.p10k.zsh.
[[ ! -f ~/ArchTitus/configs/config_files/homedir/.p10k.zsh ]] || source ~/ArchTitus/configs/config_files/homedir/.p10k.zsh

PATH="/home/lukas/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/lukas/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/lukas/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/lukas/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/lukas/perl5"; export PERL_MM_OPT;

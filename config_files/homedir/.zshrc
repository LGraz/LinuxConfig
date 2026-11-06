# Prompt: starship (pacman, config ~/.config/starship.toml if wanted, defaults otherwise)
# Plugins: pacman packages zsh-completions, zsh-autosuggestions, zsh-syntax-highlighting (no plugin manager)

source ~/LinuxConfig/config_files/homedir/.envs_and_aliases

# Load completions (zsh-completions installs into /usr/share/zsh/site-functions)
autoload -Uz compinit && compinit

# Keybindings
bindkey -e   # emacs-mode
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region
# Line navigation
bindkey "^[[H" beginning-of-line      # Home
bindkey "^[[F" end-of-line           # End
bindkey "^[[3~" delete-char          # Delete
# Word navigation
bindkey "^[[1;5C" forward-word       # Ctrl+Right
bindkey "^[[1;5D" backward-word      # Ctrl+Left
# Word deletion
bindkey "^H" backward-kill-word      # Ctrl+Backspace
bindkey "^[[3;5~" kill-word         # Ctrl+Delete


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
zstyle ':completion:*' menu select


set -k # ignore comments in zsh (thing beginning with "#")

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
eval "$(zoxide init --cmd cd zsh)"
(( $+commands[starship] )) && eval "$(starship init zsh)"

# Plugins (syntax highlighting has to be sourced last; skipped if the package is missing)
for p in zsh-autosuggestions zsh-syntax-highlighting; do
    [[ -r /usr/share/zsh/plugins/$p/$p.zsh ]] && source /usr/share/zsh/plugins/$p/$p.zsh
done


# Added by Antigravity CLI installer
export PATH="/home/lukas/.local/bin:$PATH"

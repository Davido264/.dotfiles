source ~/.profile
setopt interactivecomments

# Check that the function `starship_zle-keymap-select()` is defined.
# xref: https://github.com/starship/starship/issues/3418
type starship_zle-keymap-select >/dev/null || \
  {
    eval "$(starship init zsh)"
  }

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share/}/zsh/zinit.git"

if [ ! -d $ZINIT_HOME ]; then
    mkdir -p $ZINIT_HOME
    git clone --depth 1 https://github.com/zdharma-continuum/zinit.git $ZINIT_HOME
fi

source "${ZINIT_HOME}/zinit.zsh"

zinit ice depth=1; zinit light zsh-users/zsh-syntax-highlighting
zinit ice depth=1; zinit light zsh-users/zsh-completions
zinit ice depth=1; zinit light zsh-users/zsh-autosuggestions

autoload -U compinit
zstyle ':completion:*' menu select
fpath=(${ASDF_DIR}/completions $fpath)
compinit


HISTSIZE="10000"
HISTFILE="${XDG_DATA_HOME:-${HOME}/.local/share/}/zsh/zsh_history"
SAVEHIST="10000"
HISTDUP=erase
HISTORY_IGNORE='(clear exit)'
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

bindkey -v
bindkey '^y' autosuggest-accept
bindkey -a k history-search-backward
bindkey -a j history-search-forward

alias -- 'eza'='eza '\''--icons'\'''
alias -- 'la'='eza -a'
alias -- 'll'='eza -l'
alias -- 'lla'='eza -la'
alias -- 'ls'='eza'
alias -- 'lt'='eza --tree'
alias -- 'rmi'='rm -i'
alias -- 'vimdiff'='nvim -d'
alias -- 'vim'='nvim'
alias -- 'vi'='nvim'

smolfetch

eval "$(direnv hook zsh)"

# pnpm
export PNPM_HOME="/home/david/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

if [ -f ~/.local/share/asdf/asdf.sh ]; then
    source ~/.local/share/asdf/asdf.sh
fi

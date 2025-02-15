# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"




alias inv='nvim $(fzf -m --preview="bat --color=always {}")'


export PATH="$HOME/.tmuxifier/bin:$PATH"
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"

eval "$(tmuxifier init -)"
export PATH=$PATH:/usr/local/go/bin

HISTFILE=~/.history
HISTSIZE=10000
SAVEHIST=50000

setopt inc_append_history


# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

#zoxide
if type zoxide > /dev/null
then
  alias cd="z"
  alias cdi="zi"
fi
# eza
if type eza > /dev/null
then
  alias ls="eza -g -s Name --group-directories-first --time-style long-iso --icons=auto"
  alias l="ls -la"
  alias la="ls -la -a"
  alias ll="ls -l"
fi

# fzf
if type fzf > /dev/null
then
  export FZF_DEFAULT_OPTS=" \
  --color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
  --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
  --color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
  --color=selected-bg:#494d64 \
  --multi"
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
  alias fzf="fzf --ansi"
fi

# bat
if type bat > /dev/null
then
  export BAT_THEME="Catppuccin Macchiato"
  alias cat="bat --style=plain --paging=auto"

  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  export MANROFFOPT="-c"

  help() {
    "$@" --help 2>&1 | bat --plain --language=help
  }
fi

# lazygit
if type lazygit > /dev/null
then
  # this is a fix for not showing the correct colors using delta
  export COLORTERM=truecolor
  export XDG_CONFIG_HOME="$HOME/.config"
  # workaround for ture colors in lazygit from tmux
  # https://github.com/jesseduffield/lazygit/issues/3668
  alias lazygit='env TERM=screen-256color lazygit'
fi

#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# my func
_has() {
  return $( whence $1 >/dev/null )
}
_append_to_path() {
  if [ -d $1 -a -z ${path[(r)$1]} ]; then
    path=($path $1);
  fi
}

# Customize to your needs...
# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# alias
alias activate="source $PYENV_ROOT/versions/anaconda3-5.2.0/bin/activate"
alias deactivate="source $PYENV_ROOT/versions/anaconda3-5.2.0/bin/deactivate"

export PATH=/usr/local/bin:$PATH

# rbenv
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/shims:$PATH"

# local
export PATH="$HOME/local/bin/:$PATH"

# fzf
# fzf via Homebrew
if [ -e /usr/local/opt/fzf/shell/completion.zsh ]; then
source /usr/local/opt/fzf/shell/key-bindings.zsh
source /usr/local/opt/fzf/shell/completion.zsh
fi

# fzf via local installation
if [ -e ~/.fzf ]; then
_append_to_path ~/.fzf/bin
source ~/.fzf/shell/key-bindings.zsh
source ~/.fzf/shell/completion.zsh
fi

# fzf + ag configuration
if _has fzf && _has ag; then
export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='
--color fg:242,hl:65,fg+:15,hl+:108
--color info:108,prompt:109,spinner:108,pointer:168,marker:168
'
fi

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

# Customize to your needs...
# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# alias
alias activate="source $PYENV_ROOT/versions/anaconda3-5.2.0/bin/activate"
alias deactivate="source $PYENV_ROOT/versions/anaconda3-5.2.0/bin/deactivate"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH=/usr/local/bin:$PATH

# rbenv
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/shims:$PATH"

# local
export PATH="$HOME/local/bin/:$PATH"

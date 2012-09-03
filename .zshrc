# Path to oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Theme to load (in ~/.oh-my-zsh/themes/)
ZSH_THEME="robbyrussell"

# Plugins to load (in ~/.oh-my-zsh/plugins/)
plugins=(git rails3 bundler cap gem osx brew)

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

source $ZSH/oh-my-zsh.sh

# Editor
export VISUAL=vim
export EDITOR=vim

# Rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Aliases
alias v="vim"

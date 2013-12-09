# Path to oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Theme to load (in ~/.oh-my-zsh/themes/)
ZSH_THEME="miloshadzic"

# Plugins to load (in ~/.oh-my-zsh/plugins/)
plugins=(git rails bundler cap gem osx brew)

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

source $ZSH/oh-my-zsh.sh

# Editor
export VISUAL=mvim
export EDITOR=$VISUAL


# Homebrew cask installation dir
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Aliases
if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/colinbrock/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="sugar-free"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias nuke="rm -rf node_modules tmp dist bower_components && yarn && bower cache clean && bower install"
alias cat="bat"
alias 🦇="bat"

# https://github.com/nodenv/nodenv#homebrew-on-mac-os-x
eval "$(nodenv init -)"

# specifically for nw binary from  https://github.com/cbrock/dotfiles
export PATH=~/bin/:$PATH

# Go via homebrew
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
# =======
# https://github.com/antonmedv/fx/blob/master/DOCS.md#using-fxrc
export NODE_PATH=`npm root -g`
export VOLTA_HOME="/Users/colinbrock/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# via `brew cask info google-cloud-sdk`
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

# https://sourabhbajaj.com/mac-setup/Go/README.html
# export GOPATH=$HOME/dev
# export GOROOT=/usr/local/opt/go/libexec
# export PATH=$PATH:$GOPATH/bin
# export PATH=$PATH:$GOROOT/bin

# https://github.com/lytics/lio/blob/develop/docs/onboarding.md
export LIOHM="${HOME}/go/src/github.com/lytics/lio"
export GOPATH="${HOME}/go"
export PATH="${PATH}:/usr/local/go/bin:${GOPATH//://bin:}/bin"
alias gta="go test -p 1 ./... 2>&1 | grep -a -v 'no test'"
alias gtar="go test -p 1 -race ./... 2>&1 | grep -a -v 'no test'"
alias liostart="cd $LIOHM/devops/docker/lioenv; docker-compose start"
alias lioapistart="go run $GOPATH/src/github.com/lytics/lio/src/cmd/liod/liod.go api --config=\"$LIOHM/config/lio.conf\" --colorize"

export BIGTABLE_EMULATOR_HOST=localhost:8600
export PUBSUB_EMULATOR_HOST=localhost:8500
export LOCALGCS=/tmp/localgcs

# convenience wrappers for lioenv
docker-compose () {
    docker run -it \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v "$PWD:$PWD" \
        -w "$PWD" \
        gcr.io/lyticsstaging/docker-compose \
        "$@"
}
lioenvup () {
    pushd "$LIOHM/devops/docker/lioenv/"
    docker network inspect cloudbuild &>/dev/null || docker network create cloudbuild
    awk '/image/{print $2}' docker-compose.yml | xargs -n 1 docker pull
    docker-compose up -d &&
    sleep 10 &&
    go run $LIOHM/src/cmd/testtools/envboot/main.go
    popd
}
lioenvdown () {
    pushd "$LIOHM/devops/docker/lioenv/"
    docker-compose down &&
    docker-compose rm
    popd
}

# via `brew install mongodb-community@3.6`
export PATH="/usr/local/opt/mongodb-community@3.6/bin:$PATH"

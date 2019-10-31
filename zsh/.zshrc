export TERM="xterm-256color"

HISTSIZE=1000
SAVEHIST=$HISTSIZE
bindkey -e

[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh
[ -f $HOME/.zsh-secrets ] && source $HOME/.zsh-secrets
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh
[ -f /opt/boxen/homebrew/opt/chtf/share/chtf/chtf.sh ] && source /opt/boxen/homebrew/opt/chtf/share/chtf/chtf.sh
[ -d /opt/boxen/homebrew/opt/python/libexec/bin ] && path+=('/opt/boxen/homebrew/opt/python/libexec/bin')

binary_exists() {
  /usr/bin/which -s $1
  echo $?
}

if [[ $(uname -s) == 'Darwin' && $(binary_exists "brew") -eq 0 && -d ${HOMEBREW_ROOT} ]]; then
  export FZF_BASE=${HOMEBREW_ROOT}/Cellar/fzf/0.18.0
else
  export FZF_BASE=/usr/local/share/examples/fzf
fi
# export DISABLE_FZF_AUTO_COMPLETION="true"
# export DISABLE_FZF_KEY_BINDINGS="true"

# Oh-My-ZSH
plugins=(aws brew cargo docker docker-machine fzf gpg-agent lein mosh osx sbt scala sudo wd zsh-completions zsh-syntax-highlighting history-substring-search)
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time)
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_IGNORE_TERM_COLORS=true
DEFAULT_USER=$(whoami)
source $ZSH/oh-my-zsh.sh

fpath+=~/.zfunc

autoload -U compinit && compinit

zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

autoload -Uz ztodo
chpwd() { ztodo }

if [ $(binary_exists "brew") -eq 0 ]; then
  NVM_PREFIX=$(brew --prefix nvm)
  if [[ -d $NVM_PREFIX ]]; then
    export NVM_DIR=~/.nvm
    source $NVM_PREFIX/nvm.sh
  fi

  export HOMEBREW_NO_ANALYTICS=1
  export HOMEBREW_NO_INSECURE_REDIRECT=1
  export HOMEBREW_CACHE="/opt/boxen/cache/homebrew"
  export CASKROOM=/opt/boxen/homebrew/Caskroom
  export HOMEBREW_CASK_OPTS="--appdir=/Applications --require-sha"

  alias b="brew"
fi

if [ $(binary_exists "xdg-user-dir") -eq 0 ]; then
  DOWNLOAD_DIR=$(xdg-user-dir DOWNLOAD)
else
  DOWNLOAD_DIR="$HOME/Downloads"
fi

alias g="git"

if [[ $(uname -s) == 'Darwin' ]]; then
  alias verify-permissions="sudo /usr/libexec/repair_packages --verify --standard-pkgs /"
  alias repair-permissions="sudo /usr/libexec/repair_packages --repair --standard-pkgs --volume /"
fi

if [[ $(uname -s) == 'FreeBSD' ]]; then
  alias pnotes="date -v -4w +%Y%m%d | xargs pkg updating --date"
  # Enable VAAPI video output and hardware accelerated decoding
  # See: https://unrelenting.technology/articles/freebsd-on-the-thinkpad-x240
  alias mpv="mpv --vo=vaapi --hwdec=vaapi"
fi

alias yle-dl="yle-dl --destdir \"$DOWNLOAD_DIR/Yle Areena\" --vfat"
alias ag-clj="ag -G '.cljs?$'"
alias ag-scala="ag -G '.scala$'"
alias rg="rg --colors line:fg:yellow \
	--colors line:style:bold \
	--colors path:fg:green \
	--colors path:style:bold \
	--colors match:fg:black \
	--colors match:bg:yellow \
	--colors match:style:nobold"
alias vim="nvim"

setopt noclobber
setopt nocheckjobs
setopt interactivecomments

zstyle ':urlglobber' url-other-schema

bindkey "^[^[[C" forward-word
bindkey "^[^[[D" backward-word

path+=('/opt/bin' "${HOME}/.cargo/bin")


export LESS="-r -X"
export GOPATH=${HOME}/.go
export EDITOR=$(which nvim)
export RUST_BACKTRACE=1

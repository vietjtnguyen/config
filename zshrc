# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=100000
setopt appendhistory nomatch
unsetopt autocd
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/vnguyen/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
export PATH="$PATH:$HOME/config/bin"
bindkey '^R' history-incremental-search-backward
autoload edit-command-line; zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# https://web.archive.org/web/20140807232939/http://www.geekgumbo.com/2011/11/04/changing-the-directory-color-in-the-bash-shell/
export LS_COLORS="$LS_COLORS:di=0;35:"

export PS1="%D %* %n@%m:%d $ "

# save command history
# https://spin.atomicobject.com/2016/05/28/log-bash-history/
precmd() {
  if [ "$(id -u)" -ne 0 ]; then
    echo "$(date "+%Y-%m-%d %H:%M:%S") $(hostname):$$ $(pwd) $(history | tail -n 1)" >> ~/.logs/zsh-history-$(date "+%Y-%m-%d").log
  fi
}

if [ -z "$NVIM" ]; then
  if [ -z "$(which nvim)" ]; then
    export EDITOR="vim"
  else
    export EDITOR="nvim"
  fi
else
  if [ -z "$(which nvr)" ]; then
    export EDITOR="nvim"
  else
    export EDITOR="nvr -cc 'split' --remote-wait"
    alias nvim="nvr -cc 'split'"
  fi
fi

# https://github.com/junegunn/fzf#respecting-gitignore-hgignore-and-svnignore
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# https://github.com/junegunn/fzf/issues/809
if [ ! -z "$NVIM" ]; then
  export FZF_DEFAULT_OPTS="--no-height"
fi

if [ -n "$TMUX" ]; then
  function refresh {
    export $(tmux show-environment | grep "^SSH_AUTH_SOCK")
    export $(tmux show-environment | grep "^DISPLAY")
  }
else
  function refresh { }
fi

fzf-proj() {
  local dir
  dir=$(find /home/vnguyen/projects/*/repos -mindepth 1 -maxdepth 1 -type d -name "*$1*" | fzf +m) && cd "$dir"
}

# https://github.com/junegunn/fzf/wiki/examples

fzf-edit() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# fd - cd to selected directory
fzf-cd() {
  local dir
  dir=$(find -L ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fda - including hidden directories
fzf-cd-all() {
  local dir
  dir=$(find -L ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# fdr - cd to selected parent directory
fzf-cd-parent() {
  local declare dirs=()
  get_parent_dirs() {
    if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
    if [[ "${1}" == '/' ]]; then
      for _dir in "${dirs[@]}"; do echo $_dir; done
    else
      get_parent_dirs $(dirname "$1")
    fi
  }
  local DIR=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf-tmux --tac)
  cd "$DIR"
}

# cf - fuzzy cd from anywhere
# ex: cf word1 word2 ... (even part of a file name)
# zsh autoload function
fzf-cd-locate() {
  local file

  file="$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1)"

  if [[ -n $file ]]
  then
     if [[ -d $file ]]
     then
        cd -- $file
     else
        cd -- ${file:h}
     fi
  fi
}

# cdf - cd into the directory of the selected file
fzf-cd-file() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# fkill - kill process
fzf-kill-ps() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

# fbr - checkout git branch
fzf-git-checkout-branch() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# fco - checkout git branch/tag
fzf-git-checkout-ref() {
  local tags branches target
  tags=$(
    git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
    git branch --all | grep -v HEAD             |
    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
    (echo "$tags"; echo "$branches") |
    fzf-tmux -l30 -- --no-hscroll --ansi +m -d "\t" -n 2) || return
  git checkout $(echo "$target" | awk '{print $2}')
}

# fcoc - checkout git commit
fzf-git-checkout-commit() {
  local commits commit
  commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# fshow - git commit browser
fzf-git-commits() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# fcs - get git commit sha
# example usage: git rebase -i `fcs`
fzf-git-commit-hash() {
  echo -n "$(git log --oneline --graph --decorate --all --color=always | fzf --ansi --reverse | sed -E 's/[ |*]*([a-f0-9]+) .+/\1/g')"
}

# set up some quick ls aliases
alias ls="ls -F -G"
alias ll="ls -l"
alias la="ll -a"
alias lrt="ll -rt"

function cs() {
  cd $1; ls
}

function gpgc() {
  gpg -c --cipher-algo AES256 $@
}

function ddate() {
  date "+%Y-%m-%d-%H-%M-%S"
}

function convert_screen_recording() {
  ffmpeg -i $1 -vcodec libx264 -preset medium -crf 18 -an -vf 'scale=iw*0.5:ih*0.5' -vf 'setpts=0.25*PTS' $2
}

function git_file_md5_history() {
  FILE=$1
  (for COMMIT in $(git log --pretty=format:'%h' --all $FILE); do echo -n "${COMMIT}, "; git show $COMMIT:$FILE | md5; done)
}

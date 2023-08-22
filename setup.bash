#!/bin/bash
set -x
pushd $HOME
  echo "source ~/config/bashrc" >> .bashrc
  echo "source ~/config/zshrc" >> .zshrc
  ln -sf config/gitconfig .gitconfig
  ln -sf config/gitignore_global .gitignore_global
  ln -sf config/tmux.conf .tmux.conf
  ln -sf config/vimrc .vimrc
  mkdir -p $HOME/.config
  pushd .config
    ln -sf ../config/nvim nvim
  popd
popd

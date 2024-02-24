set nocompatible

filetype off

source config/plugins.vim
if filereadable(expand("~/.nvimrc_local"))
  source ~/.nvimrc_local
endif

filetype plugin on

let mapleader = ","


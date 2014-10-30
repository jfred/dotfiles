call plug#begin('~/.vim/plugged')

Plug 'gmarik/vundle'

" utils
Plug 'L9'
Plug 'christoomey/vim-tmux-navigator'

" Look and feel
Plug 'bling/vim-airline'
Plug 'xoria256.vim'

" Files
Plug 'Shougo/vimproc.vim'
Plug 'Shougo/vimfiler.vim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'scrooloose/nerdtree'
Plug 'benmills/vimux'

" general code
Plug 'rizzatti/dash.vim'
Plug 'tpope/vim-sleuth'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'airblade/vim-gitgutter'
Plug 'gregsexton/gitv'
"Plug 'Valloric/YouCompleteMe'

" code snippets
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
"Plug 'msanders/snipmate.vim'
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}

" go
Plug 'jnwhiteh/vim-golang'

" node/js
Plug 'digitaltoad/vim-jade'
Plug 'briancollins/vim-jst'

" java
" Plug 'vim-scripts/javacomplete'

" ruby / rails
Plug 'slim-template/vim-slim'
Plug 'tpope/vim-rails'

" python
Plug 'klen/rope-vim'

" webdev
Plug 'kchmck/vim-coffee-script'
Plug 'groenewege/vim-less'
" Plug 'skammer/vim-css-color'
Plug 'mattn/emmet-vim'
Plug 'pangloss/vim-javascript'

call plug#end()

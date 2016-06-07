call plug#begin('~/.vim/plugged')

" utils
Plug 'L9'

" Look and feel
Plug 'bling/vim-airline'
Plug 'altercation/vim-colors-solarized'

" Files
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/vimfiler.vim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'benmills/vimux'

" general code
Plug 'tpope/vim-sleuth'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'airblade/vim-gitgutter'
Plug 'gregsexton/gitv'
Plug 'ervandew/supertab'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --gocode-completer' }

if has('nvim')
    Plug 'floobits/floobits-neovim'
end

" code snippets
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
"Plug 'msanders/snipmate.vim'
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}

" go
Plug 'fatih/vim-go'
Plug 'nsf/gocode', {'rtp': 'vim/'}

" node/js
Plug 'digitaltoad/vim-jade'
Plug 'briancollins/vim-jst'

" typescript
Plug 'leafgarland/typescript-vim'

" java
Plug 'tpope/vim-classpath'

" clojure
Plug 'tpope/vim-fireplace'

" ruby / rails
Plug 'slim-template/vim-slim'
Plug 'tpope/vim-rails'

" python
" Plug 'klen/rope-vim'

" elixir
Plug 'elixir-lang/vim-elixir'

" webdev
" Plug 'kchmck/vim-coffee-script'
" Plug 'groenewege/vim-less'
" Plug 'ap/vim-css-color'
Plug 'mattn/emmet-vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

call plug#end()

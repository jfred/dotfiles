call plug#begin('~/.vim/plugged')

" utils
Plug 'L9'

" Look and feel
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'

" Files
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/vimfiler.vim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'benmills/vimux'

" Navigation
Plug 'christoomey/vim-tmux-navigator'

" general code
Plug 'tpope/vim-sleuth'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'airblade/vim-gitgutter'

" code snippets
Plug 'MarcWeber/vim-addon-mw-utils'    " required by snipmate
Plug 'tomtom/tlib_vim'                 " required by snipmate
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
Plug 'rstacruz/sparkup', {'rtp': 'vim/', 'for': 'html'}

" go
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'nsf/gocode', {'rtp': 'vim/', 'for': 'go'}

" typescript
Plug 'leafgarland/typescript-vim', {'for': 'typescript'}

" java
Plug 'tpope/vim-classpath', {'for': 'java'}

" clojure
Plug 'tpope/vim-fireplace', {'for': 'clojure'}

" ruby / rails
Plug 'slim-template/vim-slim', {'for': 'ruby'}
Plug 'tpope/vim-rails', {'for': 'rails'}

" python
Plug 'klen/rope-vim', {'for': 'python'}

" elixir
Plug 'elixir-lang/vim-elixir', {'for': 'erlang'}

" webdev
Plug 'pangloss/vim-javascript', {'for': 'javascript'}

" completion
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --gocode-completer' }

call plug#end()

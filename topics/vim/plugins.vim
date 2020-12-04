let g:has_async = v:version >= 800 || has('nvim')

call plug#begin('~/.vim/plugged')

" utils
Plug 'vim-scripts/L9'

" Look and feel
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'

" Files
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'benmills/vimux'

" Navigation
Plug 'christoomey/vim-tmux-navigator'

" general code
Plug 'vim-scripts/tComment'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'

if g:has_async
  Plug 'w0rp/ale'
endif

" go
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'nsf/gocode', {'rtp': 'vim/', 'for': 'go'}

" java
Plug 'tpope/vim-classpath', {'for': 'java'}

" clojure
Plug 'tpope/vim-fireplace', {'for': 'clojure'}

" ruby / rails
Plug 'slim-template/vim-slim', {'for': 'ruby'}
Plug 'tpope/vim-rails', {'for': 'rails'}

" python
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

" elixir
Plug 'elixir-lang/vim-elixir', {'for': 'erlang'}

" webdev
Plug 'pangloss/vim-javascript', {'for': 'javascript'}

" typescript
Plug 'leafgarland/typescript-vim', {'for': 'typescript'}

call plug#end()

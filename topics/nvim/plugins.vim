let g:has_async = 1

call plug#begin()

" utils
Plug 'vim-scripts/L9'

" Look and feel
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'

" Files
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'benmills/vimux'
Plug 'francoiscabrol/ranger.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Navigation
Plug 'christoomey/vim-tmux-navigator'

" general code
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'Yggdroot/indentLine'
Plug 'neomake/neomake'
Plug 'vim-test/vim-test'

if g:has_async
  Plug 'w0rp/ale'
endif

" go
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'nsf/gocode', {'rtp': 'vim/', 'for': 'go'}

" java
Plug 'hdiniz/vim-gradle'
Plug 'tpope/vim-classpath', {'for': 'java'}
Plug 'artur-shaik/vim-javacomplete2', {'for': 'java'}

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

set nocompatible

set encoding=utf-8

runtime plugins.vim

filetype plugin on

set backspace=indent,eol,start
set visualbell

let mapleader = ","
inoremap <C-j> <Esc>
inoremap <F2> <C-o>:w<CR>
nnoremap <F2> :w<CR>
nnoremap <C-d> :q<CR>

" defaults *******************************************************************

"set number
set pastetoggle=<F3>

set clipboard=unnamed

" Invisible characters *******************************************************
set listchars=tab:❘-,trail:·,extends:»,precedes:«,nbsp:×
set nolist
" Toggle invisible chars
noremap <Leader>? :set list!<CR>

" Tabs ***********************************************************************
set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab

" Indents
set autoindent
set smartindent
set cindent
set copyindent

set hidden            " allow for editied buffers in the background
set cursorline
set nowrap
set ruler             " show the cursor position all the time
set showcmd           " display incomplete commands
set showmatch

set foldlevelstart=20 " Don't start folded
set history=1000      " keep 50 lines of command line history
set undolevels=1000
set wildmode=list:longest
set wildignore=*.swp,*.bak,*.pyc,*.class,target,build,node_modules,logs,out

set nobackup          " do not keep a backup file, use versions instead
set noswapfile

if has('mouse')
    set mouse=a
    if !has('nvim')
        set ttymouse=xterm2
    endif
endif

" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
    set t_Co=256
    syntax on
    set omnifunc=syntaxcomplete#Complete
endif

if has("gui_running")
    " removes the toolbar in macvim
    set guioptions=egt
    set guioptions-=mrT
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Enable file type detection.
    filetype plugin indent on

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
    au!

    " When editing a file, always jump to the last known cursor position.
    autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
    augroup END

    set completeopt=menuone,menu,longest
    let g:SuperTabDefaultCompletionType = "context"
endif " has("autocmd")

" Use whole "words" when opening URLs.
" This avoids cutting off parameters (after '?') and anchors (after '#').
" See https://vi.stackexchange.com/a/2980
let g:netrw_gx="<cWORD>"

set ttimeoutlen=50

set invnumber
nmap <Leader>N :set invnumber<CR>

let g:ranger_map_keys = 0

" Sudo file if you must
cmap w!! %!sudo tee > /dev/null %

" default colorscheme - can override in ~/.vimrc_local
let g:solarized_termtrans=1
colorscheme solarized

" extra configurations
for f in split(glob($DOTFILES.'/topics/vim/config/*.vim'), '\n')
    exe 'source' f
endfor

" language specific configuration
for f in split(glob($DOTFILES.'/topics/vim/lang/*.vim'), '\n')
    exe 'source' f
endfor

" system specific
if filereadable(expand("~/.vimrc_local"))
  source ~/.vimrc_local
endif

set nocompatible

"filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

let mapleader = ","
"Why leave the home keys

inoremap <C-J> <Esc>
nnoremap ; :

" defaults *******************************************************************
let ctags_cmd='/usr/local/bin/ctags'

" system specific ************************************************************
if filereadable(expand("~/.vimrc_local"))
  source ~/.vimrc_local
endif

set number

" Invisible characters *******************************************************
set listchars=trail:.,tab:>-,eol:$
set nolist
:noremap <Leader>i :set list!<CR> " Toggle invisible chars

" Tabs ***********************************************************************
set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab

" Indents ********************************************************************
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
set wildignore=*.swp,*.bak,*.pyc,*.class

set nobackup          " do not keep a backup file, use versions instead
set noswapfile

if has('mouse')
  set mouse=a
endif

if exists('+colorcolumn')
    set colorcolumn=80,120
    highlight ColorColumn guibg=#222222 ctermbg=246
endif

if has("gui_running")
    set bg=dark
    if &background == "dark"
       hi normal guibg=black
    endif
    " removes the toolbar in macvim
    set guioptions=egt
    set guioptions-=mrT
    "set guifont="DejaVu Sans Mono":h12
    "set guifont=Menlo:h14
    " set guifont=Consolas\ Bold:h14
    set guifont=Consolas:h14
    colorscheme wombat
endif

" Sudo file if you must
cmap w!! %!sudo tee > /dev/null %

" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
  syntax on
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
else

endif " has("autocmd")

" Navigation *****************************************************************
" map <Leader>p <C-^>
" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" resize split windos
map - <C-W>-
map + <C-W>+


" NERDCommenter
" let NERDCreateDefaultMappings=0
let NERDSpaceDelims=1
map <Leader>/ <plug>NERDCommenterToggle
map <Leader>[ <plug>NERDCommenterAlignLeft
map <Leader>] <plug>NERDCommenterUncomment

" NERDTree
let NERDTreeIgnore=['\.pyc']
nmap <silent> <Leader>nd :NERDTree<CR>
nmap <silent> <Leader>nt :NERDTreeToggle<CR>

" File search ****************************************************************
set ignorecase        " ignore case when searching
set incsearch         " do incremental searching
set nohlsearch        " turn off highlight searches, but:

" Turn hlsearch off/on with CTRL-N
map <silent> <C-N> :set invhlsearch<CR>

let g:fuf_autoPreview = 0
let g:fuf_file_exclude = '\v\~$|\.(o|exe|dll|bak|pyc|sw[po])$|(^|[/\\])(\.(hg|git|bzr|egg-info)|build|dist)($|[/\\])'

map <Leader>t :FufTag<CR>
map <Leader>f :FufFile<CR>
map <Leader>F :FufTaggedFile<CR>
map <Leader>b :FufBuffer<CR>
map <Leader>l :FufLine<CR>

" tags ***********************************************************************
set tags=tags,.tags,/
execute "map <S-F8> :!".ctags_cmd." -f '.tags' --exclude='build' --extra=+f -R .<CR>"
execute "let Tlist_Ctags_Cmd='".ctags_cmd."'"
nnoremap <silent> <F8> :Tlist<CR>
let Tlist_Exit_OnlyWindow = 1     " exit if taglist is last window open
let Tlist_Show_One_File = 1       " Only show tags for current buffer
let Tlist_Enable_Fold_Column = 0  " no fold column (only showing one file)

" completion
"let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menu

" MiniBuffer
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplMapWindowNavVim = 1 

" python - virtual env ********************************************************
if filereadable($VIRTUAL_ENV . '/bin/activate_this.py')
    python import os
    python activate_this = os.environ['VIRTUAL_ENV'] + '/bin/activate_this.py'
    python execfile(activate_this, dict(__file__=activate_this))
endif

autocmd FileType python set omnifunc=pythoncomplete#Complete

" Status line
set laststatus=2
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
"set statusline=%<%f%m%r\ (%l:%c)\ %=\ %{GitBranch()}\ %h%w%y

autocmd BufRead *.mirah set filetype=ruby

" prevent falling back on bad habits
" unmap arrow keys
nmap <right> <nop>
nmap <left> <nop>
nmap <up> <nop>
nmap <down> <nop>
imap <right> <nop>
imap <left> <nop>
imap <up> <nop>
imap <down> <nop>

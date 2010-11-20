set nocompatible

filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

"set title             " set the terminal title
set autoindent        " always set autoindenting on
set copyindent
set cursorline
set expandtab
set foldlevelstart=20 " Don't start folded
set hidden            " allow for editied buffers in the background 
set hlsearch          " highlight last search
set ignorecase        " ignore case when searching
set incsearch         " do incremental searching
set nowrap
set ruler             " show the cursor position all the time
set shiftwidth=4
set showcmd           " display incomplete commands
set showmatch
set smarttab
set tabstop=4
set wildmode=list:longest 

set history=1000      " keep 50 lines of command line history
set undolevels=1000
set wildignore=*.swp,*.bak,*.pyc,*.class

set visualbell
set noerrorbells

set nobackup          " do not keep a backup file, use versions instead
set noswapfile

" for full screen
" set fuoptions=maxvert,maxhorz

" Show whitespace chars
"set list
"set listchars=tab:>.,trail:.,extends:#,nbsp:.

"set clipboard=unnamed

if has('mouse')
  set mouse=a
endif

colorscheme vividchalk
"colorscheme candycode
if has("gui_running")
    set bg=dark
    if &background == "dark"
        hi normal guibg=black
    endif
    " removes the toolbar in macvim
    set guioptions=egt
    set guioptions-=mrT
    "set guifont=Monaco:h10
    "set guifont=Consolas:h12
    "set guifont=Inconsolata:h13
    "set guifont=DejaVuSansMono:h12
endif

" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
  syntax on
" Only do this part when compiled with support for autocommands.
endif

if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
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

" remap leader
let mapleader = ","

nnoremap ; :

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

nmap <silent> ,/ :nohlsearch<CR>

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

" Python
" autocmd BufRead *.py set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
" autocmd BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

" autocmd FileType python compiler pylint
let g:pylint_cwindow=0

" File search
let g:fuf_autoPreview = 0
let g:fuf_file_exclude = '\v\~$|\.(o|exe|dll|bak|pyc|sw[po])$|(^|[/\\])(\.(hg|git|bzr|egg-info)|build|dist)($|[/\\])'

map <Leader>t :FufTag<CR>
map <Leader>F :FufFile<CR>
map <Leader>f :FufTaggedFile<CR>
map <Leader>b :FufBuffer<CR>
map <Leader>l :FufLine<CR>

" Git Status line
set laststatus=2
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
"set statusline=%<%f%m%r\ (%l:%c)\ %=\ %{GitBranch()}\ %h%w%y

" Ctags
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
nnoremap <silent> <F8> :TlistToggle<CR>
let Tlist_Exit_OnlyWindow = 1     " exit if taglist is last window open
let Tlist_Show_One_File = 1       " Only show tags for current buffer
let Tlist_Enable_Fold_Column = 0  " no fold column (only showing one file)

map <S-F8> :!/usr/local/bin/ctags -f '.tags' --exclude='build' --extra=+f -R .<CR>

set tags=tags,.tags,/

" completion
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menu

set nohlsearch          " turn off highlight searches, but:
" Turn hlsearch off/on with CTRL-N
map <silent> <C-N> :se invhlsearch<CR>

" MiniBuffer
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplMapWindowNavVim = 1 

" task list
map <leader>v <Plug>TaskList

" popups
" highlight Pmenu guibg=brown gui=bold
" highlight PmenuSel guibg=darkred
" highlight CursorLine   cterm=NONE ctermbg=darkblue ctermfg=white guibg=darkblue guifg=white

" alternative for <Esc>
inoremap <C-J> <Esc>

" resize split windos
map - <C-W>-
map + <C-W>+

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

if filereadable($VIRTUAL_ENV . '/bin/activate_this.py')
    python import os
    python activate_this = os.environ['VIRTUAL_ENV'] + '/bin/activate_this.py'
    python execfile(activate_this, dict(__file__=activate_this))
    let g:pydiction_location = $VIRTUAL_ENV . '/complete-dict'
else
    let g:pydiction_location = $PYTHON_COMPLETE_DICT
endif


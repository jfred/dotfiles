" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set foldlevelstart=20   " Don't start folded
set hidden              " allow for editied buffers in the background 
set nobackup		" do not keep a backup file, use versions instead
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
"set title		" set the terminal title
set tabstop=4
set expandtab
set shiftwidth=4
set cursorline

set nowrap

" removes the toolbar in macvim
colorscheme desert
if has("gui_running")
    " colorscheme ps_color
    colorscheme candycode
    set bg=dark
    if &background == "dark"
        hi normal guibg=black
    endif
    set transp=5
    set guioptions=egmrt
    "set guifont=Monaco:h10
    set guifont=Consolas:h12
endif

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Color styles
if !exists(":StyleDefault")
    command StyleDefault colorscheme desert  | set transp=5 | set background=dark
    command StylePlain   colorscheme default | set transp=0 | set background=light
endif

" remap leader
let mapleader = ","

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
autocmd FileType python compiler pylint
let g:pylint_cwindow=0

" File search
let g:fuzzy_ignore = "*/build/*;*/dist/*;*.egg-info/*;*.pyc"

map <Leader>t :FuzzyFinderTag<CR>
map <Leader>f :FuzzyFinderTextMate<CR>
map <Leader>b :FuzzyFinderBuffer<CR>

" Git Status line
set laststatus=2
set statusline=%<%f%m%r\ (%l:%c)\ %=\ %{GitBranch()}\ %h%w%y

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
:map <silent> <C-N> :se invhlsearch<CR>

" MiniBuffer
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplMapWindowNavVim = 1 

" popups
" highlight Pmenu guibg=brown gui=bold
" highlight PmenuSel guibg=darkred
" highlight CursorLine   cterm=NONE ctermbg=darkblue ctermfg=white guibg=darkblue guifg=white
nnoremap <silent> <F12> :bn<CR>
nnoremap <silent> <F11> :bp<CR>

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

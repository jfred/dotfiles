let ctags_cmd='/usr/local/bin/ctags'

set tags=tags,.tags,/

nmap <F8> :TagbarToggle<CR>
execute "map <F9> :!".ctags_cmd." -V -f '.tags' --exclude='build' --exclude='node_modules' --exclude='.git' --exclude='*.html' --exclude='*.js' --extra=+f -R .<CR>"

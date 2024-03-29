# Vimfiles

## Issues

On OS X, jslint will try to use the system jsc which fails. Set `JS_CMD` to
an alternate js command (etc. node) in the install specific `~/.localrc`

## Key-mappings

* `,` is `<Leader>`

##### Misc

* `,` + `i` - toggle invisible characters
* `,N` - Toggle line numbers
* `,jt` - Pass the current buffer through `python -m json.tool` to format
* `,/` - Toggle comments
* `,nt` - Toggle NERDTree (filebrowser)

##### Move between splits

* `Ctrl` + `h` - Move to left split
* `Ctrl` + `j` - Move to lower split
* `Ctrl` + `k` - Move to upper split
* `Ctrl` + `l` - Move to right split
* `Ctrl` + `N` - Toggle highlighting of search term

##### FuzzyFinder

* `,t` - Find tag
* `,f` - Find file (honoring .gitignore)
* `,F` - Find files
* `,b` - Find open buffer
* `,l` - Find line

##### Tags (ctags)

* `F8` - Show Tag List
* `F9` - Retag current directory (using ctags)

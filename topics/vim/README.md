# Vimfiles

## Todo

Still need to setup a single bootstrap function.

## Issues

On OS X, jslint will try to use the system jsc which fails. Set `JS_CMD` to
an alternate js command (etc. node) in the install specific `~/.localrc`

## Key-mappings

`,` is `<Leader>`

##### Misc

`,` + `i` - toggle invisible characters

`,N` - Toggle line numbers

`,jt` - Pass the current buffer through `python -m json.tool` to format

`,/` - Toggle comments

`,nt` - Toggle NERDTree (filebrowser)

`,tc` - Toggle 'colorizer' (highlight #rgb and #rrggbb colors)

##### Move between splits

`Ctrl` + `h` - Move to left split

`Ctrl` + `j` - Move to lower split

`Ctrl` + `k` - Move to upper split

`Ctrl` + `l` - Move to right split

`Ctrl` + `N` - Toggle highlighting of search term

##### FuzzyFinder

`,t` - Find tag

`,f` - Find file

`,F` - Find files with tags

`,b` - Find open buffer

##### Show Marks

`,mt` - Toggles ShowMarks on and off.

`,mh` - Hides an individual mark.

`,ma` - Hides all marks in the current buffer.

`,mm` - Places the next available mark.

##### Tags (ctags)

`F8` - Show Tag List

`F9` - Retag current directory (using ctags)

##### Python

`F6` - Toggle Pyflakes use of quickfix windows

`,8` - Run pep8 against current file (requires pep8 - pip install pep8)

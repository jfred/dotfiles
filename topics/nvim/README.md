# Neovim Configuration

Modern Neovim configuration using [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager.

## Features

- **Plugin Manager**: lazy.nvim (auto-installs on first launch)
- **File Navigation**: NERDTree, fzf
- **Version Control**: fugitive
- **Code Tools**: ALE linting, vim-test, tagbar
- **Language Support**: Go, Java, Python, Ruby, JavaScript, TypeScript, Clojure, Elixir
- **Colorscheme**: Solarized

## Installation

Run the install script:
```bash
./install.sh
```

Then launch nvim - lazy.nvim will automatically install on first run and download all plugins.

## Plugin Management

- `:Lazy` - Open lazy.nvim UI
- `:Lazy sync` - Install/update/clean plugins
- `:Lazy update` - Update all plugins
- `:Lazy clean` - Remove unused plugins
- `:Lazy profile` - View startup profiling

## Key Mappings

Leader key: `,`

### File Navigation
- `,nt` - Toggle NERDTree
- `,nf` - NERDTree find current file
- `,f` - FZF Git files
- `,F` - FZF All files
- `,b` - FZF Buffers
- `,l` - FZF Lines
- `,L` - FZF Ripgrep

### Code
- `,/` - Toggle comment
- `F8` - Toggle Tagbar
- `,Tf` - Run test file
- `,Tn` - Run nearest test

### Buffers
- `,n` - Next buffer
- `,p` - Previous buffer / alternate file
- `,d` - Delete buffer

### Window Navigation
- `Ctrl+h` - Move to left split
- `Ctrl+j` - Move to lower split
- `Ctrl+k` - Move to upper split
- `Ctrl+l` - Move to right split

### Misc
- `,N` - Toggle line numbers
- `,?` - Toggle invisible characters
- `Ctrl+N` - Toggle search highlighting
- `F2` - Save file

## Structure

```
config/
├── init.lua              # Main configuration
├── lua/
│   └── config/
│       └── lazy.lua      # Plugin specifications
└── ftplugin/             # Filetype-specific configs
lang/                     # Language-specific configurations
```

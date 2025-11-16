# Neovim Configuration

Modern Neovim configuration using [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager.

## Features

- **Plugin Manager**: lazy.nvim (auto-installs on first launch)
- **File Navigation**: nvim-tree, Telescope (fuzzy finder with previews)
- **LSP**: Pyright, Ruff, Docker LS, YAML LS, JSON LS (auto-installed via Mason)
- **Autocompletion**: nvim-cmp with LSP, buffer, and path sources
- **Syntax**: Treesitter for highlighting and indentation
- **Version Control**: fugitive
- **Code Tools**: ALE linting, vim-test
- **Language Support**: Python/Django, Go, Java, Ruby, JavaScript, TypeScript, Clojure, Elixir
- **Colorscheme**: TokyoNight
- **Statusline**: lualine.nvim

## Installation

Run the install script:
```bash
./install.sh nvim
```

Then launch nvim - lazy.nvim will automatically install on first run and download all plugins.

## Plugin Management

- `:Lazy` - Open lazy.nvim UI
- `:Lazy sync` - Install/update/clean plugins
- `:Lazy update` - Update all plugins
- `:Lazy clean` - Remove unused plugins
- `:Lazy profile` - View startup profiling
- `:Mason` - Manage LSP servers

## Key Mappings

Leader key: `,`

### File Navigation (Telescope)
- `,f` - Find git files (with preview)
- `,F` - Find all files (with preview)
- `,l` - Find in current buffer
- `,L` - Live grep across project (with preview)
- `,b` - Find buffers
- `,t` - Treesitter symbols
- `,h` - Help tags

### File Tree (nvim-tree)
- `,nt` - Toggle nvim-tree
- `,nf` - Find current file in tree

### LSP Navigation
- `gd` - Go to definition (with preview)
- `gD` - Go to declaration
- `gi` - Go to implementation
- `gt` - Go to type definition
- `gr` - Find all references (with preview and context)
- `K` - Hover documentation

### LSP Search (Telescope)
- `,ss` - Document symbols (classes/functions in current file)
- `,sS` - Workspace symbols (all symbols in project)
- `,sd` - Search diagnostics

### LSP Actions
- `,rn` - Rename symbol across project
- `,ca` - Code actions (quick fixes)
- `[d` - Previous diagnostic
- `]d` - Next diagnostic

### Telescope Controls
- `Ctrl+j` / `Ctrl+k` - Move up/down in list
- `Esc` - Close
- `Ctrl+q` - Send results to quickfix list

### Code
- `,/` - Toggle comment
- `,Tf` - Run test file
- `,Tn` - Run nearest test

### Django/Python (in Python files)
- `,tp` - Run all tests (with --noinput)
- `,tm` - Run tests for current module
- `,dm` - Django manage.py (prompts for command)
- `,ds` - Django shell
- `,dr` - Django runserver
- `,dd` - Django migrate
- `,fb` - Format with black
- `,fr` - Format with ruff

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

## Autocompletion

Autocompletion is provided by nvim-cmp with the following sources:
- LSP (classes, methods, functions)
- Buffer (words in current buffer)
- Path (file paths)
- Snippets (LuaSnip)

**Controls:**
- `Tab` / `Shift+Tab` - Navigate suggestions
- `Enter` - Confirm selection
- `Ctrl+Space` - Trigger completion
- `Ctrl+b` / `Ctrl+f` - Scroll documentation

## Structure

```
config/
├── init.lua              # Main Lua configuration
└── lua/
    ├── config/
    │   └── lazy.lua      # lazy.nvim setup
    └── plugins/          # Plugin specifications (split by category)
        ├── ui.lua        # Statusline, colorscheme, file tree
        ├── navigation.lua # Telescope, tmux integration
        ├── coding.lua    # Comments, git, testing, linting
        ├── lsp.lua       # LSP, treesitter, Mason
        ├── completion.lua # nvim-cmp autocompletion
        └── languages.lua  # Language-specific plugins
lang/                     # Language-specific configurations (VimScript)
└── python-django.vim     # Django keybindings and terminal runner
```

## Environment Configuration

For Django projects, set `DOCKER_EXEC` in your `.envrc` to run commands in containers:

```bash
# Local development (no container)
export DOCKER_EXEC=""

# Docker Compose
export DOCKER_EXEC="docker-compose exec app"

# Plain Docker
export DOCKER_EXEC="docker exec -it mycontainer"
```

See `extras/mise/.envrc.template` for a complete example.

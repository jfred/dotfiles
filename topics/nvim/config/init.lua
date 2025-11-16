-- Neovim configuration with lazy.nvim
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

-- Basic settings
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- General settings
vim.opt.encoding = "utf-8"
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.visualbell = true
vim.opt.clipboard = "unnamed"

-- Line numbers
vim.opt.number = true
vim.keymap.set("n", "<Leader>N", ":set invnumber<CR>", { silent = true })

-- Invisible characters
vim.opt.listchars = { tab = "❘-", trail = "·", extends = "»", precedes = "«", nbsp = "×" }
vim.opt.list = false
vim.keymap.set("n", "<Leader>?", ":set list!<CR>", { silent = true })

-- Tabs and indentation
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = true
vim.opt.copyindent = true

-- Buffer and display settings
vim.opt.hidden = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.ruler = true
vim.opt.showcmd = true
vim.opt.showmatch = true
vim.opt.foldlevelstart = 20
vim.opt.history = 1000
vim.opt.undolevels = 1000

-- Search settings
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Wildmenu
vim.opt.wildmode = "list:longest"
vim.opt.wildignore = { "*.swp", "*.bak", "*.pyc", "*.class", "target", "build", "node_modules", "logs", "out" }

-- Backup and swap
vim.opt.backup = false
vim.opt.swapfile = false

-- Enable project-local config files (.nvim.lua in project root)
vim.opt.exrc = true

-- Mouse support
vim.opt.mouse = "a"

-- Syntax and colors
vim.opt.termguicolors = true
vim.opt.background = "dark"

-- Timeout settings
vim.opt.ttimeoutlen = 50

-- Netrw settings
vim.g.netrw_gx = "<cWORD>"
vim.g.ranger_map_keys = 0

-- Key mappings
vim.keymap.set("i", "<C-j>", "<Esc>", { silent = true })
vim.keymap.set("i", "<F2>", "<C-o>:w<CR>", { silent = true })
vim.keymap.set("n", "<F2>", ":w<CR>", { silent = true })
vim.keymap.set("n", "<C-d>", ":q<CR>", { silent = true })

-- Clear search highlighting
vim.keymap.set("n", "<Leader><space>", ":nohlsearch<CR>", { silent = true })
vim.keymap.set("n", "<C-N>", ":set invhlsearch<CR>", { silent = true })

-- Navigate splits with Ctrl+hjkl
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l:redraw!<CR>", { silent = true })

-- Hack to get C-h working in neovim
vim.keymap.set("n", "<BS>", ":TmuxNavigateLeft<CR>", { silent = true })

-- History scrolling in command mode
vim.keymap.set("c", "<C-p>", "<Up>")
vim.keymap.set("c", "<C-n>", "<Down>")

-- Buffer navigation
vim.keymap.set("n", "<Leader>n", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "<Leader>p", ":bprev<CR>", { silent = true })
vim.keymap.set("n", "<Leader>d", ":bdelete<CR>", { silent = true })
vim.keymap.set("n", "<Leader>p", "<C-^>", { silent = true })

-- Prevent arrow keys
vim.keymap.set("n", "<right>", "<nop>")
vim.keymap.set("n", "<left>", "<nop>")
vim.keymap.set("n", "<up>", "<nop>")
vim.keymap.set("n", "<down>", "<nop>")
vim.keymap.set("i", "<right>", "<nop>")
vim.keymap.set("i", "<left>", "<nop>")
vim.keymap.set("i", "<up>", "<nop>")
vim.keymap.set("i", "<down>", "<nop>")

-- Search mappings - center on found line
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- Sudo write
vim.cmd("cmap w!! %!sudo tee > /dev/null %")

-- Autocmds
local augroup = vim.api.nvim_create_augroup("vimrcEx", { clear = true })

-- Jump to last cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- Setup lazy.nvim and load plugins
require("config.lazy")


-- Load language-specific configurations
local dotfiles = vim.env.DOTFILES
if dotfiles then
  local lang_files = vim.fn.glob(dotfiles .. "/topics/nvim/lang/*.vim", false, true)
  for _, file in ipairs(lang_files) do
    vim.cmd("source " .. file)
  end
end

-- Load local overrides
local local_config = vim.fn.expand("~/.nvimrc_local")
if vim.fn.filereadable(local_config) == 1 then
  vim.cmd("source " .. local_config)
end

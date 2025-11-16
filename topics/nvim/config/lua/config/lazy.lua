-- lazy.nvim plugin configuration
require("lazy").setup({
  -- Look and feel
  {
    "vim-airline/vim-airline",
    dependencies = { "vim-airline/vim-airline-themes" },
    config = function()
      vim.g.airline_powerline_fonts = 0
      vim.opt.laststatus = 2
    end,
  },
  {
    "altercation/vim-colors-solarized",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.solarized_termtrans = 1
      vim.cmd("colorscheme solarized")
    end,
  },

  -- Files and navigation
  {
    "preservim/nerdtree",
    dependencies = {
      "Xuyuanp/nerdtree-git-plugin",
      "ryanoasis/vim-devicons",
    },
    keys = {
      { "<Leader>nt", ":NERDTreeToggle<CR>", silent = true, desc = "Toggle NERDTree" },
      { "<Leader>nf", ":NERDTreeFind<CR>", silent = true, desc = "NERDTree find file" },
    },
    config = function()
      vim.g.NERDTreeMinimalUI = 1
      vim.g.NERDTreeDirArrows = 1
      vim.g.NERDTreeRespectWildIgnore = 1

      -- Open NERDTree by default
      local augroup = vim.api.nvim_create_augroup("NERDTree", { clear = true })
      vim.api.nvim_create_autocmd("StdinReadPre", {
        group = augroup,
        callback = function()
          vim.g.std_in = 1
        end,
      })
      vim.api.nvim_create_autocmd("VimEnter", {
        group = augroup,
        callback = function()
          if vim.fn.argc() == 0 and not vim.g.std_in then
            vim.cmd("NERDTree")
            vim.cmd("wincmd p")
          end
        end,
      })

      -- Exit Vim if NERDTree is the only window left
      vim.api.nvim_create_autocmd("BufEnter", {
        group = augroup,
        pattern = "*",
        command = [[if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif]],
      })
    end,
  },
  {
    "junegunn/fzf",
    build = function()
      vim.fn["fzf#install"]()
    end,
  },
  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
    keys = {
      { "<Leader>f", ":GFiles<CR>", silent = true, desc = "FZF Git files" },
      { "<Leader>F", ":Files<CR>", silent = true, desc = "FZF Files" },
      { "<Leader>l", ":Lines<CR>", silent = true, desc = "FZF Lines" },
      { "<Leader>L", ":Rg<CR>", silent = true, desc = "FZF Ripgrep" },
      { "<Leader>b", ":Buffers<CR>", silent = true, desc = "FZF Buffers" },
      { "<Leader>t", ":Tags<CR>", silent = true, desc = "FZF Tags" },
    },
  },
  { "benmills/vimux" },
  { "francoiscabrol/ranger.vim", dependencies = { "rbgrouleff/bclose.vim" } },

  -- Navigation
  { "christoomey/vim-tmux-navigator" },

  -- General code
  {
    "majutsushi/tagbar",
    keys = {
      { "<F8>", ":TagbarToggle<CR>", silent = true, desc = "Toggle Tagbar" },
    },
    config = function()
      vim.g.ctags_cmd = "/usr/local/bin/ctags"
      vim.opt.tags = { "tags", ".tags", "/" }
    end,
  },
  { "tpope/vim-endwise" },
  { "tpope/vim-projectionist" },
  {
    "tpope/vim-commentary",
    keys = {
      { "<Leader>/", ":Commentary<CR>", mode = { "n", "v" }, desc = "Toggle comment" },
    },
  },
  { "tpope/vim-fugitive" },
  { "tpope/vim-sleuth" },
  { "tpope/vim-surround" },
  { "Yggdroot/indentLine" },
  { "neomake/neomake" },
  {
    "vim-test/vim-test",
    config = function()
      vim.g["test#strategy"] = "vimux"
    end,
    keys = {
      { "<Leader>Tf", ":TestFile<CR>", silent = true, desc = "Test file" },
      { "<Leader>Tn", ":TestNearest<CR>", silent = true, desc = "Test nearest" },
    },
  },
  {
    "dense-analysis/ale",
    config = function()
      vim.opt.updatetime = 1000
      vim.g.ale_lint_on_text_changed = 0
    end,
  },

  -- Language specific
  { "fatih/vim-go", ft = "go" },
  { "hdiniz/vim-gradle" },
  { "tpope/vim-classpath", ft = "java" },
  { "mfussenegger/nvim-jdtls", ft = "java" },
  { "tpope/vim-fireplace", ft = "clojure" },
  { "slim-template/vim-slim", ft = "ruby" },
  { "tpope/vim-rails", ft = "rails" },

  -- Python/Django enhanced support
  -- Note: Using Pyright + Ruff LSP instead of python-mode for better performance
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "python", "lua", "vim", "vimdoc", "javascript", "typescript", "html", "css", "json", "yaml", "dockerfile" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "ruff", "dockerls", "yamlls", "jsonls" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- Use the new vim.lsp.config API (nvim 0.11+)
      vim.lsp.config("pyright", {})
      vim.lsp.config("ruff", {})
      vim.lsp.config("dockerls", {})
      vim.lsp.config("yamlls", {})
      vim.lsp.config("jsonls", {})

      -- Enable all configured LSPs
      vim.lsp.enable({ "pyright", "ruff", "dockerls", "yamlls", "jsonls" })

      -- Key mappings for LSP
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf, desc = "Go to definition" })
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = args.buf, desc = "Hover documentation" })
          vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, { buffer = args.buf, desc = "Rename symbol" })
          vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, { buffer = args.buf, desc = "Code action" })
          vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = args.buf, desc = "Find references" })
        end,
      })
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
      })
    end,
  },

  -- Django templates
  { "tweekmonster/django-plus.vim", ft = { "python", "htmldjango" } },

  -- Docker/Compose
  { "ekalinin/Dockerfile.vim", ft = "dockerfile" },

  { "elixir-lang/vim-elixir", ft = "erlang" },
  { "pangloss/vim-javascript", ft = "javascript" },
  { "leafgarland/typescript-vim", ft = "typescript" },
}, {
  -- lazy.nvim options
  ui = {
    border = "rounded",
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

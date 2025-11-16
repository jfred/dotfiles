-- General coding plugins: tags, comments, git, testing, linting
return {
  -- Code structure
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

  -- Editing helpers
  { "tpope/vim-endwise" },
  { "tpope/vim-projectionist" },
  {
    "tpope/vim-commentary",
    keys = {
      { "<Leader>/", ":Commentary<CR>", mode = { "n", "v" }, desc = "Toggle comment" },
    },
  },
  { "tpope/vim-sleuth" },
  { "tpope/vim-surround" },

  -- Git
  { "tpope/vim-fugitive" },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local opts = { buffer = bufnr }

          -- Navigation
          vim.keymap.set("n", "]c", function()
            if vim.wo.diff then return "]c" end
            vim.schedule(function() gs.next_hunk() end)
            return "<Ignore>"
          end, vim.tbl_extend("force", opts, { expr = true, desc = "Next hunk" }))

          vim.keymap.set("n", "[c", function()
            if vim.wo.diff then return "[c" end
            vim.schedule(function() gs.prev_hunk() end)
            return "<Ignore>"
          end, vim.tbl_extend("force", opts, { expr = true, desc = "Prev hunk" }))

          -- Actions
          vim.keymap.set("n", "<Leader>hs", gs.stage_hunk, vim.tbl_extend("force", opts, { desc = "Stage hunk" }))
          vim.keymap.set("n", "<Leader>hr", gs.reset_hunk, vim.tbl_extend("force", opts, { desc = "Reset hunk" }))
          vim.keymap.set("n", "<Leader>hp", gs.preview_hunk, vim.tbl_extend("force", opts, { desc = "Preview hunk" }))
          vim.keymap.set("n", "<Leader>hb", function() gs.blame_line({ full = true }) end, vim.tbl_extend("force", opts, { desc = "Blame line" }))
        end,
      })
    end,
  },

  -- Testing
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

  -- Linting (fallback for non-LSP languages)
  {
    "dense-analysis/ale",
    config = function()
      vim.opt.updatetime = 1000
      vim.g.ale_lint_on_text_changed = 0
      -- Disable ALE for languages covered by LSP
      vim.g.ale_linters_explicit = 1
      vim.g.ale_linters = {
        python = {}, -- LSP handles Python via Pyright/Ruff
        javascript = {},
        typescript = {},
      }
    end,
  },
}

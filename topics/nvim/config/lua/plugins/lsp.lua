-- LSP plugins: language servers, treesitter, mason
return {
  -- Treesitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "python",
          "lua",
          "vim",
          "vimdoc",
          "javascript",
          "typescript",
          "html",
          "css",
          "json",
          "yaml",
          "dockerfile",
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- Mason for LSP server management
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

  -- LSP configuration
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
          local opts = { buffer = args.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
          vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
          vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
          vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
          vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Find references" }))
        end,
      })
    end,
  },
}

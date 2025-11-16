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

      -- Key mappings for LSP (uses Telescope for better previews)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf }
          local builtin = require("telescope.builtin")

          -- Go to commands (direct jump)
          vim.keymap.set("n", "gd", builtin.lsp_definitions, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
          vim.keymap.set("n", "gi", builtin.lsp_implementations, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
          vim.keymap.set("n", "gt", builtin.lsp_type_definitions, vim.tbl_extend("force", opts, { desc = "Go to type definition" }))

          -- Find commands (with preview)
          vim.keymap.set("n", "gr", builtin.lsp_references, vim.tbl_extend("force", opts, { desc = "Find references (with preview)" }))
          vim.keymap.set("n", "<Leader>ss", builtin.lsp_document_symbols, vim.tbl_extend("force", opts, { desc = "Document symbols" }))
          vim.keymap.set("n", "<Leader>sS", function()
            builtin.lsp_dynamic_workspace_symbols()
          end, vim.tbl_extend("force", opts, { desc = "Workspace symbols" }))
          vim.keymap.set("n", "<Leader>sc", function()
            builtin.lsp_dynamic_workspace_symbols({ symbols = "class" })
          end, vim.tbl_extend("force", opts, { desc = "Search classes" }))
          vim.keymap.set("n", "<Leader>sf", function()
            builtin.lsp_dynamic_workspace_symbols({ symbols = { "function", "method" } })
          end, vim.tbl_extend("force", opts, { desc = "Search functions/methods" }))

          -- Actions
          vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
          vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
          vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))

          -- Diagnostics
          vim.keymap.set("n", "<Leader>sd", builtin.diagnostics, vim.tbl_extend("force", opts, { desc = "Search diagnostics" }))
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
        end,
      })
    end,
  },
}

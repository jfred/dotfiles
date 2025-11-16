-- Navigation plugins: fuzzy finder, file manager, tmux integration
return {
  -- Telescope (fuzzy finder with previews)
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<Leader>f", "<cmd>Telescope git_files<CR>", silent = true, desc = "Find git files" },
      { "<Leader>F", "<cmd>Telescope find_files<CR>", silent = true, desc = "Find all files" },
      { "<Leader>l", "<cmd>Telescope current_buffer_fuzzy_find<CR>", silent = true, desc = "Find in buffer" },
      { "<Leader>L", "<cmd>Telescope live_grep<CR>", silent = true, desc = "Live grep" },
      { "<Leader>b", "<cmd>Telescope buffers<CR>", silent = true, desc = "Find buffers" },
      { "<Leader>h", "<cmd>Telescope help_tags<CR>", silent = true, desc = "Help tags" },
      { "<Leader>t", "<cmd>Telescope treesitter<CR>", silent = true, desc = "Treesitter symbols" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<Esc>"] = actions.close,
            },
          },
          file_ignore_patterns = {
            "node_modules",
            ".git/",
            "__pycache__",
            "%.pyc",
          },
          layout_config = {
            horizontal = {
              preview_width = 0.55,
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
          live_grep = {
            additional_args = function()
              return { "--hidden" }
            end,
          },
        },
      })
    end,
  },

  -- Tmux integration
  { "benmills/vimux" },
  { "christoomey/vim-tmux-navigator" },

  -- Ranger file manager
  { "francoiscabrol/ranger.vim", dependencies = { "rbgrouleff/bclose.vim" } },
}

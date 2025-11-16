-- UI plugins: statusline, colorscheme, file tree
return {
  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          component_separators = { left = "|", right = "|" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  -- Colorscheme
  {
    "altercation/vim-colors-solarized",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.solarized_termtrans = 1
      vim.cmd("colorscheme solarized")
    end,
  },

  -- File tree
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<Leader>nt", ":NvimTreeToggle<CR>", silent = true, desc = "Toggle NvimTree" },
      { "<Leader>nf", ":NvimTreeFindFile<CR>", silent = true, desc = "NvimTree find file" },
    },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
        },
        renderer = {
          icons = {
            show = {
              git = true,
              folder = true,
              file = true,
              folder_arrow = true,
            },
          },
        },
        filters = {
          dotfiles = false,
        },
        git = {
          enable = true,
          ignore = false,
        },
      })

      -- Open nvim-tree on startup when no file specified
      local augroup = vim.api.nvim_create_augroup("NvimTree", { clear = true })
      vim.api.nvim_create_autocmd("VimEnter", {
        group = augroup,
        callback = function(data)
          -- Only open if directory or no args
          local is_directory = vim.fn.isdirectory(data.file) == 1
          local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

          if is_directory then
            vim.cmd.cd(data.file)
            require("nvim-tree.api").tree.open()
          elseif no_name then
            require("nvim-tree.api").tree.open()
            vim.cmd("wincmd p")
          end
        end,
      })
    end,
  },

  -- Indentation guides
  { "Yggdroot/indentLine" },
}

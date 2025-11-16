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

  -- Indentation guides
  { "Yggdroot/indentLine" },
}

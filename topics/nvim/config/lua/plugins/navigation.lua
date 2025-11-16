-- Navigation plugins: fuzzy finder, file manager, tmux integration
return {
  -- FZF
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

  -- Tmux integration
  { "benmills/vimux" },
  { "christoomey/vim-tmux-navigator" },

  -- Ranger file manager
  { "francoiscabrol/ranger.vim", dependencies = { "rbgrouleff/bclose.vim" } },
}

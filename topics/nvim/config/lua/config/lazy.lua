-- lazy.nvim plugin configuration
-- Automatically imports all plugin specs from lua/plugins/
require("lazy").setup("plugins", {
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

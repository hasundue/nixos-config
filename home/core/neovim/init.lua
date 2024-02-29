-- enable experimental lua loader
vim.loader.enable()

-- base configurations, independent of plugins
require("rc/options")

-- load plugins with lazy.nvim
require("lazy").setup({
  defaults = {
    lazy = true,
  },
  spec = {
    import = "rc/plugins",
  },
  install = {
    colorscheme = { "kanagawa" },
  },
})

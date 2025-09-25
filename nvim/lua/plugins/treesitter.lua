-- lua/plugins/treesitter.nvim
local treesitter = require("nvim-treesitter.configs")

parsers = require('plugins.core').ts_parsers

treesitter.setup({
  ensure_installed = parsers,
  highlight = { enable = true },
  indent = { enable = true },
})


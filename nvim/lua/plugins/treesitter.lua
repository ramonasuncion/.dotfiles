-- treesitter.nvim
local treesitter = require("nvim-treesitter.configs")

-- FIXME: AutoInstall function.
parsers = require('plugins.core').ts_parsers

treesitter.setup({
  ensure_installed = parsers,
  highlight = {
    enable = true,
    disable = { "c" },
    additional_vim_regex_highlighting = false,
  },
  custom_captures = {
    ["include"] = "Include",
    ["null"] = "Null",
  },
  autopairs = {
    enable = true,
  },
  indent = { enable = true },
})


-- lua/plugins/fzf.lua
local fzf = require('fzf-lua')

fzf.setup({
  height = 0.9,
  width = 0.7,
  winopts = {
    border = "single",
    preview = {
      layout = "horizontal",
      vertical = "down:65%",
      border = "border",
    },
  },
  keymap = {
    builtin = {
      ["<S-j>"] = "preview-page-down",
      ["<S-k>"] = "preview-page-up",
    },
  },
})

vim.keymap.set("n", "<C-d>", fzf.files)
vim.keymap.set("n", "<C-S-d>", fzf.git_files)

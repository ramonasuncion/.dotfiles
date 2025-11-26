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

-- plugin-specific keymaps
vim.keymap.set("n", "<leader>f", fzf.files)
vim.keymap.set("n", "<leader>g", fzf.git_files)
vim.keymap.set("n", "<leader>m", fzf.marks)

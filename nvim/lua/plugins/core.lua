-- lua/plugins/core.lua
vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" },
  { src = "https://github.com/ibhagwan/fzf-lua", version = "main" },
  { src = "https://github.com/nvim-mini/mini.surround", version = "main" },
  { src = "https://github.com/windwp/nvim-autopairs.git"},
})

local function load(pkg)
  pcall(require, "plugins." .. pkg)
end

load("lspconfig")
load("treesitter")
load("fzf")
load("mini_surround")
load("autopairs")

local ts_parsers = { 'c', 'cpp', 'python' }

return {
  ts_parsers = ts_parsers,
}


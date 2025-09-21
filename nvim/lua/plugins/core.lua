-- init.lua
local function load(package)
  return function()
    require('plugins.' .. package)
  end
end

vim.pack.add({
  {
    src = 'https://github.com/ray-x/lsp_signature.nvim.git',
    name = 'lsp_signature.nvim',
    load = load('lspsignature')
  },
  {
    src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    name = 'nvim-treesitter',
    version = 'main',
    data = { build = ':TSUpdate' },
    load = load('treesitter'),
  },
  {
    src = 'https://github.com/ibhagwan/fzf-lua',
    name = 'fzf-lua',
    version = 'main',
    load = load('fzf'),
  },
  {
    src = 'https://github.com/nvim-mini/mini.surround',
    name = 'mini-surround',
    version = 'stable',
  },
})

local ts_parsers = { 'c', 'cpp', 'lua', 'vimdoc' }
local lsp_servers = { 'typos_lsp' }

return {
  ts_parsers = ts_parsers,
  lsp_servers = lsp_servers,
}


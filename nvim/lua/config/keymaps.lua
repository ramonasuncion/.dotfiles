local function map(mode, lhs, rhs, opts)
  local options = { noremap=true, silent=true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- modes: https://neovim.io/doc/user/map.html#map-modes

-- leader
vim.g.mapleader=","

-- disable arrow keys
map('', '<up>', '<nop>')
map('', '<down>', '<nop>')
map('', '<left>', '<nop>')
map('', '<right>', '<nop>')

-- move around splits (Ctrl+{j,k,l,h})
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- reload vim
map('n', '<leader>r', ':so %<CR>')

-- fast saving
map('n', '<leader>s', ':w<CR>')

-- quit
map('n', '<leader>q', ':qa!<CR>')

-- clear search
map('n', '<leader>c', ':nohl<CR>')



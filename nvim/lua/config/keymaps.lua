-- move around splits (Ctrl+{j,k,l,h})
vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true, desc = 'Move to left split' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true, desc = 'Move to below split' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true, desc = 'Move to above split' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true, desc = 'Move to right split' })

-- reload vim
vim.keymap.set('n', '<leader>r', '<cmd>so %<cr>', { silent = true, desc = 'Reload config' })

-- fast saving
vim.keymap.set('n', '<leader>s', '<cmd>w<cr>', { silent = true, desc = 'Save file' })

-- quit
vim.keymap.set('n', '<leader>q', '<cmd>qa!<cr>', { silent = true, desc = 'Quit all' })

-- clear search
vim.keymap.set('n', '<leader>c', '<cmd>nohl<cr>', { silent = true, desc = 'Clear search' })

-- keep centered
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-f>', '<C-f>zz')
vim.keymap.set('n', '<C-b>', '<C-b>zz')

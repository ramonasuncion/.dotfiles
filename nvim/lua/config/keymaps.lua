-- move around splits (Ctrl+{j,k,l,h})
vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true, desc = 'left split' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true, desc = 'below split' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true, desc = 'above split' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true, desc = 'right split' })

-- reload vim
vim.keymap.set('n', '<leader>r', '<cmd>source $MYVIMRC<cr>', { silent = true, desc = 'reload' })

-- fast saving
vim.keymap.set('n', '<leader>s', '<cmd>w<cr>', { silent = true, desc = 'save' })

-- quit
vim.keymap.set('n', '<leader>q', '<cmd>qa!<cr>', { silent = true, desc = 'quit' })

-- clear search
vim.keymap.set('n', '<leader>c', '<cmd>nohl<cr>', { silent = true, desc = 'clear' })

-- keep centered
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-f>', '<C-f>zz')
vim.keymap.set('n', '<C-b>', '<C-b>zz')

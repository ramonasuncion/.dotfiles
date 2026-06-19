local iron = require('iron.core')
local hs_file = ''

iron.setup({
  config = {
    scratch_repl = true,
    repl_definition = {
      haskell = {
        command = function(_)
          return { 'ghci', hs_file }
        end,
      },
    },
    repl_open_cmd = function(bufnr)
      local view = require('iron.view')
      if vim.o.columns < 120 then
        return view.split.botright(0.3)(bufnr)
      end
      return view.split.vertical.botright(0.4)(bufnr)
    end,
  },
  ignore_blank_lines = true,
})

vim.keymap.set('n', '<leader>hi', function()
  hs_file = vim.api.nvim_buf_get_name(0)
  iron.repl_for('haskell')
end, { desc = 'open/toggle ghci' })

vim.keymap.set('n', '<leader>hl', function()
  local line = vim.api.nvim_get_current_line()
  iron.send('haskell', (line:gsub('^%s*%-%-+%s?', '')))
end, { desc = 'send line' })
vim.keymap.set('v', '<leader>hv', function() iron.visual_send() end, { desc = 'send selection' })
vim.keymap.set('n', '<leader>hr', function() iron.send('haskell', ':reload') end, { desc = 'reload' })
vim.keymap.set('n', '<leader>hx', function() iron.send('haskell', '\x0c') end, { desc = 'clear' })
vim.keymap.set('n', '<leader>he', function()
  local expr = vim.fn.input('ghci> ')
  if expr ~= '' then iron.send('haskell', expr) end
end, { desc = 'eval expression' })
vim.keymap.set('n', '<leader>hd', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled({ bufnr = 0 }), { bufnr = 0 })
end, { desc = 'toggle diagnostics' })

-- lua/plugins/lspconfig.lua
-- https://gist.github.com/MariaSolOs/2e44a86f569323c478e5a078d0cf98cc
local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, opts)

  local function keymap(lhs, rhs, desc, mode)
    mode = mode or 'n'
    local o
    if type(desc) == 'string' then o = { desc = desc, buffer = bufnr } else o = desc or {}; o.buffer = bufnr end
    vim.keymap.set(mode, lhs, rhs, o)
  end

  local function feedkeys(keys)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), 'n', true)
  end

  local function pumvisible() return vim.fn.pumvisible() ~= 0 end

  if client:supports_method('textDocument/completion') then
    vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })

    -- trigger completion when typing keyword characters
    vim.api.nvim_create_autocmd('InsertCharPre', {
      buffer = bufnr,
      callback = function()
        if not pumvisible() and vim.v.char:match('[%w_]') then
          vim.schedule(function() vim.lsp.completion.get() end)
        end
      end,
    })

    -- CR: accept if an item is selected, otherwise dismiss and newline
    keymap('<CR>', function()
      if pumvisible() then
        local info = vim.fn.complete_info({ 'selected' })
        if info.selected >= 0 then
          return '<C-y>'
        end
        return '<C-e><CR>'
      end
      return '<CR>'
    end, { expr = true }, 'i')

    keymap('<C-n>', function()
      if pumvisible() then
        feedkeys('<C-n>')
      else
        if next(vim.lsp.get_clients({ bufnr = 0 })) then
          vim.lsp.completion.get()
        else
          if vim.bo.omnifunc == '' then feedkeys('<C-x><C-n>') else feedkeys('<C-x><C-o>') end
        end
      end
    end, 'Trigger/select next completion', 'i')
    keymap('<C-u>', '<C-x><C-n>', { desc = 'Buffer completions' }, 'i')

    keymap('<Tab>', function()
      if pumvisible() then
        return '<C-y>'
      elseif vim.snippet and vim.snippet.active { direction = 1 } then
        vim.snippet.jump(1)
        return ''
      else
        return '<Tab>'
      end
    end, { expr = true }, { 'i', 's' })

    keymap('<S-Tab>', function()
      if pumvisible() then
        return '<C-p>'
      elseif vim.snippet and vim.snippet.active { direction = -1 } then
        vim.snippet.jump(-1)
        return ''
      else
        return '<S-Tab>'
      end
    end, { expr = true }, { 'i', 's' })

    keymap('<BS>', '<C-o>s', {}, 's')
  end
end

local servers = {
  clangd = { filetypes = { 'c', 'cpp' } },
  pyright = { cmd = { 'pyright-langserver', '--stdio' }, filetypes = { 'python' } },
  typos_lsp = { cmd = { 'typos-lsp' }, filetypes = { '*' } },
}

for name, cfg in pairs(servers) do
  cfg.on_attach = on_attach
  vim.lsp.config(name, cfg)
  vim.lsp.enable(name)
end


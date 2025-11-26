-- lua/plugins/lspconfig.lua
local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
end

vim.lsp.config("clangd", {
  cmd = { "clangd" },
  filetypes = { "c", "cpp" },
  on_attach = on_attach,
})

vim.lsp.enable("clangd")

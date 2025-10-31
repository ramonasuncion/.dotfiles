-- lua/plugins/lspconfig.lua
vim.keymap.set("i", "<CR>", function()
  if vim.fn.pumvisible() == 1 then
    return vim.api.nvim_replace_termcodes("<C-e><CR>", true, true, true)
  else
    return vim.api.nvim_replace_termcodes("<CR>", true, true, true)
  end
end, { expr = true })
vim.keymap.set("i", "<Tab>", function()
  if vim.fn.pumvisible() == 1 then
    return vim.api.nvim_replace_termcodes("<C-y>", true, true, true)
  else
    return vim.api.nvim_replace_termcodes("<Tab>", true, true, true)
  end
end, { expr = true })

local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr }

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, opts)

  vim.lsp.completion.enable(true, client.id, bufnr, {
    convert = function(item)
      local abbr = item.label:gsub("%b()", ""):gsub("%b{}", "")
      abbr = abbr:match("[%w_.]+.*") or abbr
      abbr = #abbr > 15 and abbr:sub(1, 14) .. "…" or abbr

      local menu = item.detail or ""
      menu = #menu > 15 and menu:sub(1, 14) .. "…" or menu

      return { abbr = abbr, menu = menu }
    end,
  })

  vim.api.nvim_create_autocmd("CursorHoldI", {
    buffer = bufnr,
    callback = function() vim.lsp.buf.signature_help() end,
  })
end

vim.lsp.config("clangd", {
  cmd = { "clangd" },
  filetypes = { "c", "cpp" },
  on_attach = on_attach,
})

vim.lsp.enable("clangd")


-- GUI
vim.opt.termguicolors = true

-- color scheme
local colorscheme = "twilight"

-- try default colorscheme first
local ok, _ = pcall(vim.api.nvim_command, "colorscheme " .. colorscheme)
if not ok then
  pcall(vim.api.nvim_command, "colorscheme sorbet")
end

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.au",
  callback = function()
    vim.bo.filetype = "aurum"
    pcall(vim.cmd, "colorscheme aurum")
  end,
})


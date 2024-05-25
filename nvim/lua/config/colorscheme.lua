-- GUI
vim.opt.termguicolors = true

-- color scheme
local colorscheme = "twilight"

-- check highlight ok
local ok, _ = pcall(vim.api.nvim_command, "colorscheme " .. colorscheme)
if not ok then
  print("Error setting colorscheme!")
end


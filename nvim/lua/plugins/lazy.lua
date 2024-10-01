-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

local plugins = require("plugins.core").plugins

lazy.setup({
  root = vim.fn.stdpath("data") .. "/lazy",
  defaults = { lazy = false },
  spec = plugins,
  lockfile = vim.fn.stdpath("config") .. "/lua/plugins/lock.json",
  dev = { path = "~/projects/", patterns = {}, fallback = false },
  git = {
    log = { "-8" },
    timeout = 120,
    url_format = "https://github.com/%s.git",
    filter = true,
  },
  ui = {
    size = { width = 0.9, height = 0.8 },
    wrap = true,
    border = "rounded",
    browser = nil,
    throttle = 20,
    custom_keys = {
      ["<localleader>l"] = function(plugin)
        require("lazy.util").float_term({ "lazygit", "log" }, {
          cwd = plugin.dir,
        })
      end,

      ["<localleader>t"] = function(plugin)
        require("lazy.util").float_term(nil, {
          cwd = plugin.dir,
        })
      end,
    },
  },
  diff = { cmd = "git" },
  checker = { enabled = false },
  change_detection = { enabled = true, notify = true },
  performance = {
    cache = { enabled = true },
    reset_packpath = true,
    rtp = {
      reset = true,
      paths = {},
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "zipPlugin",
        "tohtml",
      },
    },
  },
  --readme = {
  --  root = vim.fn.stdpath("state") .. "/lazy/readme",
  --  files = { "README.md", "lua/**/README.md" },
  --  skip_if_doc_exists = true,
  --},
  --state = vim.fn.stdpath("state") .. "/lazy/state.json",
})


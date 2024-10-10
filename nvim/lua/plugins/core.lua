local function load(package)
  return function()
    require('plugins.' .. package)
  end
end

local plugins = {
  {
    'tpope/vim-surround',
  },
  {
    'neovim/nvim-lspconfig',
    config = load('lspconfig'),
    event = { 'BufReadPre', 'BufNewFile' },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = load('treesitter'),
    event = { 'BufReadPre', 'BufNewFile' },
  },
  {
    'ray-x/lsp_signature.nvim',
    config = load('lspsignature'),
  },
  {
    'ibhagwan/fzf-lua',
    cmd = "FzfLua",
    opts = {
      height = 0.9,
      width = 0.7,
      winopts = {
        border = "single",
        preview = {
          layout = "horizontal",
          vertical = "down:65%",
          border = "border",
        },
      },
      keymap = {
        builtin = {
          ["<S-j>"] = "preview-page-down", -- Shift + j
          ["<S-k>"] = "preview-page-up", -- Shift + k
        },
      },
    },
    keys = {
      { "<C-d>", "<cmd>lua require('fzf-lua').files()<cr>" },
      { "<C-S-d>", "<cmd>lua require('fzf-lua').git_files()<cr>" },
    },
  },
  {
    'BurntSushi/ripgrep',
  },
}

local ts_parsers = {
  'c', 'cpp', 'lua', 'vimdoc'
}

local lsp_servers = {
  'typos_lsp',
}

return {
  plugins = plugins,
  lsp_servers = lsp_servers,
  ts_parsers = ts_parsers,
}


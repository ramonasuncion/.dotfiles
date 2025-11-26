-- lua/plugins/mini_surround.lua
local surround = require('mini.surround')

surround.setup({
  mappings = {
    add = 'sa',
    delete = 'sd',
    replace = 'sr',
    find = 'sf',
    find_left = 'sF',
    highlight = 'sh'
  },
})


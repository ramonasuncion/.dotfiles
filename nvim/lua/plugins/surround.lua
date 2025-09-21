-- mini.surround
local surround = require('mini.surround')

surround.setup({
  custom_surroundings = nil,
  highlight_duration = 500,
  mappings = {
    add = 'sa', -- surrounding in normal and visual
    delete = 'sd', -- delete surround
    find = 'sf', -- find surround (to right)
    find_left = 'sF', -- find surround (to left)
    highlight = 'sh', -- highlight surround
    replace = 'sr', -- replace surround
    update_n_lines = 'sn', -- update n_line

    suffix_last = 'l', -- search with prev
    suffix_next = 'n', -- search with next
  },
  n_lines = 20, -- lines to search
  respect_selection_type = false,
  search_method = 'cover',
  silent = false,
})


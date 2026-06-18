local clue = require('mini.clue')

clue.setup({
  triggers = {
    { mode = 'n', keys = '<leader>' },
    { mode = 'v', keys = '<leader>' },
  },
  clues = {
    { mode = 'n', keys = '<leader>h', desc = 'haskell repl' },
    clue.gen_clues.g(),
    clue.gen_clues.z(),
  },
  window = {
    delay = 300,
    config = { border = 'single' },
  },
})

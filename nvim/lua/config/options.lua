-- local variables
local opt = vim.opt
local cmd = vim.cmd

-- block cursor
opt.guicursor = ""

-- persistent undo
opt.undofile=true
opt.undodir=vim.fn.stdpath('config') .. '/undo'

-- clipboard
opt.clipboard = 'unnamedplus'

-- whitespace character
local dot="·"
opt.list=true
opt.listchars:append {
  multispace=dot,
  lead=dot,
  space=dot,
  nbsp=dot,
  trail=dot,
}

-- how many lines of history VIM remembers
opt.history=500

-- potential sever issues with backup files
opt.backup=false
opt.writebackup=false

-- updatime default is 4000 ms = 4s.
opt.updatetime=300

-- do signcolumn=yes:1 in lua
opt.signcolumn='yes:1'

-- enable mouse
opt.mouse='a'

-- sign column
opt.scl='no'

-- set auto read whne a file is changed from outside
opt.autoread=true

-- be smart when using tabs
opt.smarttab=true

--  handle indentation
opt.autoindent=true

-- 1 tab == 2 spaces
opt.shiftwidth=2
opt.tabstop=2

-- use spaces instead of tabs
opt.expandtab=true

-- line break on 500 characters
opt.lbr=true
opt.tw=500
opt.wrap=true

-- set 7 lines to the cursor when moving vertically.
opt.so=7

-- height of the command bar
opt.cmdheight=1

-- buffer becomes hidden when abandoned
opt.hidden=true

-- configure backspace
opt.backspace:append { 'eol', 'start', 'indent' }

-- automatically wrap left and right.
opt.whichwrap:append {
  ['<'] = true,
  ['>'] = true,
  ['['] = true,
  [']'] = true,
  h = true,
  l = true
}

-- ignore case when searching
opt.ignorecase=true

-- when searching try to be smart about cases
opt.smartcase=true

-- heightlight search results
opt.hlsearch=true

-- set the number index
opt.number=true

-- set the relative line numbers
opt.relativenumber=true

-- real time search results as the user types
opt.incsearch=true

-- do not redraw while executing macros (use if you frequently replay macros)
opt.lazyredraw=true

-- moving to matching braces
opt.showmatch=true
opt.matchtime=2


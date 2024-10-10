-- local variables
local opt = vim.opt
local cmd = vim.cmd

-- block cursor
opt.guicursor = ""

-- persistent undo
opt.udf=true
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

-- utf-8 byte sequence
opt.encoding='utf-8'

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

-- enable clipboard
-- use :help clipboard to setup copy and pasting. (download xclip)
opt.clipboard:append { 'unnamedplus' }

-- set auto read whne a file is changed from outside
opt.autoread=true

-- toggle rainbow parentheses
vim.g.rainbow_active=1

-- set the cursor property when working in a GUI (gvim)
opt.guicursor='n-v-c-i:block'

-- be smart when using tabs
opt.smarttab=true
--opt.cindent=true

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

-- turn on wild menu
opt.wildmenu=true

-- always show current position
opt.ruler=true

-- height of the command bar
opt.cmdheight=1

-- buffer becomes hidden when abandoned
opt.hid=true

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

-- magic mode for regular expressions (default=true)
opt.magic=true

-- moving to matching braces
opt.showmatch=true
opt.matchtime=2


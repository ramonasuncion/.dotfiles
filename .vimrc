if has("win32") || has("win64")
  au GUIEnter * simalt ~x
endif
set ls=2 nu ts=2 sw=2 sts=2 mouse=a ut=750 wrap et ai si hls is fo+=r
syntax on
set cb=unnamed
inoremap { {}<Left>
inoremap {<CR> {<CR>}<Esc>O
inoremap {{ {
inoremap {} {}

" C++
autocmd FileType cpp nnoremap <F9> :w<CR>:!clang++ -std=c++17 % -o %:r.exe<CR>
autocmd FileType cpp nnoremap <F10> :!%:r.exe<CR>
autocmd FileType cpp nnoremap <F11> :w<CR>:!clang++ -std=c++17 % -o %:r.exe && %:r.exe<CR>
autocmd FileType cpp setlocal com=s1:/*,mb:*,ex:*/,://

" Python
autocmd FileType python nnoremap <F9> :w<CR>:!python3 %<CR>
autocmd FileType python setlocal com=s1:#,mb:#,ex:#

set backspace=indent,eol,start

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set rnu
  autocmd BufLeave,FocusLost,InsertEnter * set nornu
augroup END

nnoremap <C-s> :w<CR>
set noswapfile nobackup nowritebackup
filetype plugin indent on
set autoread

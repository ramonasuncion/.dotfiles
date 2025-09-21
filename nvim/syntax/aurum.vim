" Language: aurum
" Maintainer: Ramon Asuncion
" Description: syntax highlighting for aurum language

if exists("b:current_syntax")
  finish
endif

set iskeyword=@,48-57,192-255

" keywords and tokens
syn keyword aurumTodos TODO XXX FIXME NOTE
syn keyword aurumControlKeywords if then else while end do define
syn keyword aurumConstants final include
syn keyword aurumStackKeywords dup swap roll over peek rot drop dump 2drop 2dup 2swap 2over
syn keyword aurumMemoryKeywords memory write read store fetch
syn keyword aurumMiscKeywords systemcall ascii

" comments
syn region aurumCommentLine  start="//" end="$"   contains=aurumTodos
syn region aurumCommentBlock start="/\*" end="\*/" contains=aurumTodos

" strings and chars
syn region aurumString start=/\v"/ skip=/\v\\./ end=/\v"/ contains=aurumEscapes
syn region aurumChar   start=/\v'/ skip=/\v\\./ end=/\v'/ contains=aurumEscapes
syn match  aurumEscapes display contained "\\[nr\"']"

" numbers
syn match aurumNumber /\d\+/

" highlight linking
highlight default link aurumTodos Todo
highlight default link aurumCommentLine Comment
highlight default link aurumCommentBlock Comment
highlight default link aurumChar Character
highlight default link aurumEscapes SpecialChar
highlight default link aurumControlKeywords Keyword
highlight default link aurumConstants Constant
highlight default link aurumStackKeywords Statement
highlight default link aurumMemoryKeywords Function
highlight default link aurumMiscKeywords Keyword
highlight default link aurumString String
highlight default link aurumNumber Number

let b:current_syntax = "aurum"


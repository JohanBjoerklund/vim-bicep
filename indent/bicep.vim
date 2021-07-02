" Vim syntax file
" Language: Bicep
" Maintainer: Johan Björklund
" URL: https://github.com/JohanBjoerklund/vim-bicep
" Forked from https://github.com/hashivim/vim-terraform

if exists('b:did_indent')
  finish
endif

let b:did_indent = 1

let s:cpo_save = &cpoptions
set cpoptions&vim

setlocal nolisp
setlocal autoindent shiftwidth=2 tabstop=2 softtabstop=2 expandtab
setlocal indentexpr=DoIndent(v:lnum)

let b:undo_indent = 'setlocal lisp< autoindent< shiftwidth< tabstop< softtabstop<'
      \ . ' expandtab< indentexpr< indentkeys<'

" TODO: Don't indent in multiline strings
function! DoIndent(lnum)

  if a:lnum == 0
    return 0
  endif

  let prevlnum = prevnonblank(a:lnum-1)
  let thisindent = indent(prevlnum)

  let prevline = getline(prevlnum)

  if prevline !~# '^\s*//' && prevline =~# '[\[{]\s*$'
    let thisindent += &shiftwidth
  endif

  let thisline = getline(a:lnum)
  if thisline =~# '^\s*[}\]]'
    let thisindent -= &shiftwidth
  endif

  if prevline =~# '/\*'
    let thisindent += 1
  endif

  if prevline =~# '\*/'
    let thisindent -= 1
  endif

  return thisindent
endfunction

let &cpoptions = s:cpo_save
unlet s:cpo_save


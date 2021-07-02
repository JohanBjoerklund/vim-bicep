" Vim syntax file
" Language: Bicep
" Maintainer: Johan Björklund
" URL: https://github.com/JohanBjoerklund/vim-bicep

if exists('b:current_syntax')
  finish
endif

syn case match

syn keyword bicepRepeat       for in
syn keyword bicepConditional  if
syn keyword bicepKeyword      existing module output param resource targetScope var
syn keyword bicepType         array bool int object string
syn keyword bicepBoolean      true false

syn region bicepStringExpression contained start=+${+ end=+}+
syn region bicepString start=/[']/ skip=/\/\// end=/[']/ contains=bicepStringExpression
syn region bicepString start=/[''']/ skip=/\/\// end=/[''']/

syn match bicepApiVersion /\d\{4}-\d\{2}-\d\{2}[-preview]*/
syn match bicepType /[']\{1}[a-zA-Z./]\+@\d\{4}-\d\{2}-\d\{2}[-preview]*[']\{1}/
syn match bicepBraces /[\[\]]/

syn keyword bicepTodo contained TODO
syn region  bicepComment start="//" end="$" contains=bicepTodo,@Spell
syn region  bicepComment start="/\*" end="\*/" contains=bicepTodo,@Spell

syn match bicepFunction "[a-z0-9A-Z]\+(\@="

hi def link bicepRepeat           Repeat
hi def link bicepConditional      Conditional
hi def link bicepBoolean          Boolean
hi def link bicepString           String
hi def link bicepComment          Comment
hi def link bicepType             Type
hi def link bicepKeyword          StorageClass
hi def link bicepDecorator        Function
hi def link bicepFunction         Function

let b:current_syntax = 'bicep'

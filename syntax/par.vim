syntax sync minlines=300

syntax keyword parCond if then else
syntax keyword parKeyword
  \ module import export impl let in match try catch ensure after raise discard
  \ assume test assert
syntax keyword parKeyword enum nextgroup=parEnum skipwhite
syntax keyword parKeyword struct nextgroup=parStruct skipwhite
syntax keyword parKeyword interface nextgroup=parInterface skipwhite
syntax keyword parKeyword impl nextgroup=parImplType skipwhite
syntax keyword parKeyword exception nextgroup=parException skipwhite
syntax keyword parKeyword export nextgroup=parGlobal skipwhite

syntax match parEnum "\v<[A-Z]\w+>"
  \ nextgroup=parEnumParams,parEnumBraces skipwhite contained
syntax region parEnumParams start=/</ end=/>/ contains=parType,parComment
  \ nextgroup=parEnumBraces skipwhite contained
syntax region parEnumBraces start=/{/ end=/}/
  \ contains=parEnumParens,parAtom,parComment contained
syntax region parEnumParens start=/(/ end=/)/
  \ contains=parEnumParens,parType,parDelim,parComment contained

syntax match parStruct "\v<[A-Z]\w+>"
  \ nextgroup=parStructParams,parStructBraces skipwhite contained
syntax region parStructParams start=/</ end=/>/ contains=parType,parComment
  \ nextgroup=parStructBraces skipwhite contained
syntax region parStructBraces start=/{/ end=/}/ contains=parType,parComment
  \ contained

syntax match parInterface "\v<[A-Z]\w+>"
  \ nextgroup=parExtendsRegion skipwhite contained
syntax region parExtendsRegion start=/extends/ end=/{/
  \ contains=parExtends,parType,parDelim,parComment contained
syntax keyword parExtends extends contained

syntax match parImplType "\v<[A-Z]\w+>"
  \ nextgroup=parForRegion skipwhite contained
syntax region parForRegion start=/for/ end=/{/
  \ contains=parFor,parType,parDelim,parComment contained
syntax keyword parFor for contained

syntax match parException "\v<[A-Z]\w+>"
  \ nextgroup=parEnumParens skipwhite contained

syntax match parGlobal "\v^\s*[a-z_]\w*(\?=|>)\ze(\(.{-}\))=\s*\=($|[^=>])"
syntax match parGlobal "\v\s*[a-z_]\w*(\?=|>)\ze(\(.{-}\))=\s*\=($|[^=>])"
  \ contained
syntax match parConVar "\v<[A-Z]\w+>"

syntax match parType "\v<[A-Z]\w+>" contained
syntax match parType "\v<[A-Z]>"

syntax keyword parBool true false
syntax match parDelim "\v(\[|\])"
syntax match parSpecial "\v(([^\|]\zs|^)\|(\>|\ze[^\|]|$)|\$|\*)"

syntax match parSigGlobal "\v^\s*[a-z_]\w*(\?=|>)\ze\s*:"
  \ nextgroup=parSig skipwhite
syntax region parSig start=/:/ end=/\v(^\s*)=([a-z]|}|\/\/)/re=s-1,me=s-1
  \ contains=parType,parDelim contained

syntax match parNumber "\v<(\d+\.?\d*|\.\d+)>"

syntax match parChar "\v'(\\.|.)'" contains=parEscChar
syntax match parEscChar "\v\\." contained
syntax match parBadChar "\v'(\\.|[^\\']){-2,}'"
syntax match parBadChar "\v'(\\.|[^\\']){-2,}$"he=s+3
syntax match parBadChar "\v'\n'"
syntax match parBadChar "''"

syntax match parAtom "\v<\@\w+>"
syntax region parAtom start=/@"/ skip=/\\"/ end=/\v("|$)/
  \ contains=parBadNl,parEscCharNl oneline
syntax region parString start=/"/ skip=/\\"/ end=/\v("|$)/
  \ contains=parBadNl,parEscCharNl oneline
syntax match parBadNl "\v[^"]$" contained excludenl
syntax match parEscCharNl "\v\\\_." contained
syntax region parRawString start=/`/ end=/`/

syntax region parComment start=/\/\// end=/$/ contains=parTodo
syntax keyword parTodo TODO FIXME NOTE BUG HACK XXX contained

highlight default link parCond Conditional
highlight default link parKeyword Keyword
highlight default link parFor Keyword
highlight default link parExtends Keyword
highlight default link parEnum Type
highlight default link parStruct Type
highlight default link parInterface Type
highlight default link parImplType Type
highlight default link parType Type
highlight default link parBool Boolean
highlight default link parDelim Delimiter
highlight default link parSpecial Special
highlight default link parGlobal Function
highlight default link parConVar Identifier
highlight default link parNumber Number
highlight default link parChar Character
highlight default link parEscChar SpecialChar
highlight default link parBadChar Error
highlight default link parAtom Special
highlight default link parString String
highlight default link parRawString String
highlight default link parBadNl Error
highlight default link parEscCharNl SpecialChar
highlight default link parTuple SpecialChar
highlight default link parComment Comment
highlight default link parTodo Todo

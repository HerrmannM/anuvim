" Vim syntax file
" Language   : Anubis
" Maintainers: Matthieu Herrmann
" Last Change: 2014 September

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

" Note: :help group-name for standard highlight groups
" Note: '\=' is the same as '\?'
syn sync fromstart
syn sync linebreaks=1
set textwidth=120


" ----- TERMS:
" -- Private predefined
syn keyword aPredefPrivate    contained   +++vcopy +++type_desc +++serialize +++unserialize +++tempserialize
syn keyword aPredefPrivate    contained   +++tempunserialize +++Listener +++StructPtr +++avm
hi link aPredefPrivate    PreProc
" -- Terms
syn keyword aTermCond         contained   since is if then else ensure otherwise
syn keyword aTermTodo         contained   todo
syn keyword aTermSNH          contained   should_not_happen
syn keyword aTermOther        contained   with terminal
syn keyword aTermVM           contained   protect lock delegate
syn match   aTermVM           contained   display   "\(wait\s+for\)\|\(checking\s+every\)"
syn keyword aTermDeprecrated  contained   alert
hi link aTermCond         Conditional
hi link aTermTodo         Todo
hi link aTermSNH          Exception
hi link aTermOther        Keyword
hi link aTermVM           Statement
hi link aTermDeprecrated  Error
" -- Cluster
syn cluster aKW contains=aTermCond,aTermTodo,aTermSNH,aTermOther,aTermVM,aTermDeprecrated,aPredefType,aPredefPrivate

" ----- CONSTANTS
" -- Special char definition
syn match aSpecialChar        contained   display   "\\[nrt\"\\]"
syn match aSpecialCharError   contained   display   "\\[^nrt\"\\]"
hi link aSpecialChar      SpecialChar
hi link aSpecialCharError Error
" -- Char constant. Order matters ! aCharError must be first, is override when
"  ok by, e.g. '\n' which is more than 2 symbols but is valid.
syn match aCharError  contained   display   "'[^']\{2,}'"
syn match aChar       contained   display   "'[^'\\]'"
syn match aChar       contained   display   "'\\[^']'" contains=aSpecialChar,aSpecialCharError
hi link aCharError  Error
hi link aChar       Character
" -- String constant
syn region aString  contained extend start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=aSpecialChar,aSpecialCharError,@Spell
hi link aString     String
" ----- numbers:
syn match aInteger  contained   display "\<\d\+"
syn match aFloat    contained   display "\<\d\+\.\d\+"
hi link aInteger  Number
hi link aFloat    Float
" -- Cluster
syn cluster aConst contains=aCharError,aChar,aString,aInteger,aFloat

" ----- IDENTIFIERS:
" -- Predefined types
syn keyword aPredefType   contained   String ByteArray TempByteArray Int Int32 Omega Float
syn keyword aPredefType   contained   RStream WStream RWStream GAddr Var MVar
syn keyword aOpaqueType   contained   Opaque
hi link aPredefType   StorageClass
hi link aOpaqueType   Define
" -- Types
syn match aType   contained   display "\<[A-Z][_a-zA-Z0-9]*\>"
hi link aType     Type
" -- Identifiers
syn match aJocker       contained   display "\<_\>"
syn match aIdentifier   contained   display "\<[a-z][_a-zA-Z0-9]*\>"
syn match aIdentifier   contained   display "\<_[_a-zA-Z0-9]\+\>"
" hi link aIdentifier     Identifier
hi link aJocker         Special
" -- Cluster
syn cluster aId contains=aPredefType,aOpaqueType,aType,aJocker,aIdentifier


" ----- OPERATORS:
" -- Short
syn match aShortOp  contained   display "\(\.\)\|:\|;\|-\|%\|,\|\~\|+\|*\|\^\|&\|=\||\|/\|<\|>"
hi link aShortOp Operator
" -- Long
syn match aLongOp       contained   display "\(::\)\|\(|-|\)\|\(\.\.\)\|\(\s\+\.\s\+\)\|\(\.>\)"
syn match aLongOp       contained   display "\(/=\)\|\(!=\)\|\(>>\)\|\(<<\)\|\(\\\\\)"
syn match aLongOp       contained   display "\(=<\)\|\(>=\)\|\(-<\)\|\(>-\)\|\(-=<\)"
syn match aLongOp       contained   display "\(>=-\)\|\(+<\)\|\(>+\)\|\(+=<\)\|\(>=+\)"
syn match aLongOp       contained   display "\(<->\)\|\(<-\)\|\(->>\)\|\(|->>\)"
hi link aLongOp Underlined
" -- Function type/operator
syn match aFunOp       contained   display "\(->\)\|\(|->\)"
syn match aFunOp       contained   display "|-\s*[_a-z][_a-zA-Z0-9]*\s*->"
hi link aFunOp Function
" -- Match over
syn match aMatchOver    contained   display "\((\s*mod\s\)\|\((\)\|\()\)\|\(,\s*)\)\|\({\)"
syn match aMatchOver    contained   display "\(}\)\|\(,\s*}\)\|\(\[\)\|\(\]\)\|\(,\s*\]\)"
hi link aMatchOver Underlined
" -- Cluster
syn cluster aOp contains=aShortOp,aLongOp,aFunOp,aMatchOver

" ----- COMMENTS: contained in paragraphs
" Note: Must be after operators
" -- Special text
syn match   aCommentTodo    contained display "\([Tt]odo\|TODO\):"
syn match   aCommentTodo    contained display "\([Nn]ote\|NOTE\):"
syn match   aCommentTodo    contained display "\([Ww]arning\|WARNING\):"
syn match   aCommentUnder   contained display  "\*\*.*\*\*"
hi link aCommentTodo    TODO
hi link aCommentUnder   Underlined
" -- Main comment out of any paragraphs

"syn include @MAML syntax/maml.vim
"syn region mamlRegion start=+\$begin+ keepend end=+\$end+ contains=@MAML contained
"
syn match aMainComment "^\s.*$"  contains=@Spell,aCommentTodo,mamlRegion
hi link aMainComment Comment





" -- Comment at the end of a paragraph
 " syn match aEndComment contained  display "\s*\(\.\|:\(\_s*\.\.\.\)\?\)\zs\s*\(//.*\)\?$" contains=@Spell
" hi link aEndComment Comment
" -- One line // comment inside paragraphs
syn match aParComment  extend "//.*$" contains=@Spell,aCommentTodo,aCommentUnder
hi link aParComment Comment
" -- /* */ comments
syn region aMultiComment extend start='/\*' matchgroup=Comment end='\*/' contains=aMultiComment,@Spell,aCommentTodo,aCommentUnder
hi link aMultiComment Comment
" -- Special coloration inside comments
" -- Cluster
syn cluster aComment contains=aParComment,aMultiComment


" ----- BIG CLUSTER
syn cluster anubis contains=@aKW,@aConst,@aId,@aOp,@aComment

" ----- PARAGRAPHS:
" -- Paragraph starts. Order matters !
" --- Coloration for start
syn match aStartError     contained   "."
syn match aStartPub       contained   display "^\<[Pp]ublic\>"
syn match aStartPub       contained   display "^\<[Gg]lobal\>"
syn match aStartPub       contained   display "^\<[Mm]odule\>"
syn match aStartDefine    contained   display "\<[Dd]efine\>"
syn match aStartType      contained   display "\<[Tt]ype\>"
syn match aStartMacro     contained   display "\<macro\>"
syn match aStartInline    contained   display "\<inline\>"
hi link aStartError   Error
hi link aStartPub     Label
hi link aStartDefine  Define
hi link aStartType    Define
hi link aStartMacro   Macro
hi link aStartInline  Macro
" -- Cluster
syn cluster aStart contains=aStartError,aStartPub,aStartDefine,aStartType,aStartMacro,aStartInline

" ----- TYPE
syn match aTypeParStart contained "^\([Pp]ublic\_s*\)\=[Tt]ype" contains=@aStart nextgroup=aTypeBody
syn region aTypePar start="^\([Pp]ublic\_s*\)\=[Tt]ype" end="\s*\(\.\|:\_s*\.\.\.\)\ze\s*\(//.*\)\=$" transparent contains=aTypeParStart keepend
syn region aTypeBody contained start="." matchgroup=SpecialChar end="\s*\(\.\|:\_s*\.\.\.\)\ze\s*\(//.*\)\=$" contains=@anubis keepend

" ----- DEFINE
syn match aDefineParStart contained "^\([Pp]ublic\_s*\|[Gg]lobal\_s*\)\=[Dd]efine\_s*\(macro\|inline\)\=" contains=@aStart nextgroup=aDefineBody
syn region aDefinePar start="^\([Pp]ublic\_s*\|[Gg]lobal\_s*\)\=[Dd]efine\_s*\(macro\|inline\)\=" end="\s*\.\ze\s*\(//.*\)\=$" transparent contains=aDefineParStart keepend
syn region aDefineBody contained start="." matchgroup=SpecialChar end="\s*\.\ze\s*\(//.*\)\=$" contains=@anubis keepend

" ----- READ/TRANSMIT
syn match   aRead         display   skipwhite "^[Rr]ead\|^[Tt]ransmit" nextgroup=aReadPath
syn match   aRead         display   skipwhite "^[Rr]eplaced\s+by" nextgroup=aReadPath
syn match   aReadPath     display   skipwhite contained "\s*[/\._a-zA-Z0-9-]*" nextgroup=aReadComment
syn match   aReadComment  display   contained ".*$" contains=@Spell,aCommentTodo,aCommentUnder
hi link aReadPath    Identifier
hi link aReadComment Comment
hi link aRead        Include

" ----- EXECUTE
syn match   aExecCMD    display   skipwhite contained ".*$"
syn match   aExecute    display   skipwhite "^[Ee]xecute" nextgroup=aExecCMD
hi link aExecCMD    Statement
hi link aExecute    Include

" ----- TODO
syn match   aTodo         display   skipwhite "^to[\ ]*do:.*$"
hi link aTodo TODO

" ----- DESCRIBE
syn match   aDescribe     display   skipwhite "^[Dd]escribe" nextgroup=aReadComment
hi link aDescribe macro

" ----- FOLD
syn region aFold start="{" end="}" transparent contained fold containedin=aDefineBody

let b:current_syntax = "anubis"

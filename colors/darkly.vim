" Vim colour file
" Name: darkly
" Maintainer: Stuart McConnell
" Version: 1.2

set background=dark

hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name="darkly"

" Vim >= 7.0 specific colors
if version >= 700
    "hi MatchParen    guifg=#f6f3e8    guibg=#857b6f "gui=bold
    hi CursorLine                    guibg=#2d2d2d
    hi CursorColumn                  guibg=#2d2d2d
    hi MatchParen    guifg=#f6f3e8    guibg=#857b6f
    hi Pmenu        guifg=#f6f3e8    guibg=#444444
    hi PmenuSel      guifg=#000000    guibg=#cae682
endif

" General colors
hi Normal          guifg=#DDDDDD    guibg=#1e2426
hi Cursor          guifg=NONE      guibg=#656565
hi NonText        guifg=#808080    guibg=#1e2426
hi LineNr          guifg=#666666    guibg=#1e2426
hi StatusLine      guifg=#f6f3e8    guibg=#444444
hi StatusLineNC    guifg=#857b6f    guibg=#444444
hi VertSplit      guifg=#444444    guibg=#444444
hi Folded          guifg=#a0a8b0    guibg=#384048
hi Title          guifg=#f6f3e8    guibg=NONE
hi Visual          guifg=#f6f3e8    guibg=#444444
hi SpecialKey      guifg=#808080    guibg=#343434

hi Search         guifg=#f0a0c0 guibg=#302028 gui=underline
hi IncSearch         guifg=#f0a0c0 guibg=#302028 gui=underline

" Syntax highlighting
" hi Comment        guifg=#677c99                   gui=italic
hi Comment        guifg=#505050 
hi Operator        guifg=#a080f0
hi Todo            guifg=#333333    guibg=#cccccc
hi Constant        guifg=white
" hi String          guifg=#4ac0fa                   gui=italic
hi String          guifg=#4ac0fa
hi Identifier      guifg=#6BFFBD
hi Underlined      guifg=#6BFFBD                   gui=underline
hi Italics         guifg=#6BFFFD                   gui=italic
hi Define          guifg=#6BFFBD
hi Function        guifg=#6BFFFD
hi Macro          guifg=#6BFFBD
hi Number          guifg=#eda987
hi Special        guifg=#999999
hi Conditional    guifg=#6BFFBD
hi Boolean        guifg=#99dd99
hi Delimiter      guifg=#999999
hi Character      guifg=#55d2ee
" hi Search          guifg=black      guibg=#6BFFFD
hi Visual                          guibg=#303030
hi Type           guifg=#6BFFFD
hi Keyword        guifg=#6BFFFD
hi Statement      guifg=#8ac6f2
hi PreProc        guifg=#a080f0
hi Error          guifg=#eeeeec   guibg=#cc0000

" HTML
hi htmlTag            guifg=#888a85
hi htmlEndTag         guifg=#888a85
hi htmlTagName        guifg=#babdb6
hi htmlSpecialTagName guifg=#babdb6
hi htmlArg            guifg=#d3d7cf
hi htmlTitle          guifg=#8ae234   gui=none
hi link htmlH1 htmlTitle
hi link htmlH2 htmlH1
hi link htmlH3 htmlH1
hi link htmlH4 htmlH1
hi link htmlH5 htmlH1
hi link htmlH6 htmlH1
hi link htmlLink      Underlined

" XML
hi link xmlTag htmlTag
hi link xmlEndTag htmlEndTag
hi link xmlAttrib htmlArg

" CSS
hi cssSelectorOp      guifg=#eeeeec
hi link cssSelectorOp2 cssSelectorOp
hi cssUIProp          guifg=#d3d7cf
hi link cssPagingProp cssUIProp
hi link cssGeneratedContentProp cssUIProp
hi link cssRenderProp cssUIProp
hi link cssBoxProp cssUIProp
hi link cssTextProp cssUIProp
hi link cssColorProp cssUIProp
hi link cssFontProp cssUIProp
hi cssPseudoClassId   guifg=#eeeeec
hi cssBraces          guifg=#888a85
hi cssIdentifier      guifg=#fcaf3e
hi cssTagName         guifg=#fcaf3e
hi link cssInclude Function
hi link cssCommonAttr Constant
hi link cssUIAttr Constant
hi link cssTableAttr Constant
hi link cssPagingAttr Constant
hi link cssGeneratedContentAttr Constant
hi link cssAuralAttr Constant
hi link cssRenderAttr Constant
hi link cssBoxAttr Constant
hi link cssTextAttr Constant
hi link cssColorAttr Constant
hi link cssFontAttr Constant

" CoffeeScript
hi link coffeeObject Underlined

" JavaScript
hi link javaScriptFunction Italics

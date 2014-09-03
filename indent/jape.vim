" Vim indent file
" Language: Jape
" Maintainer:   nikolavp@gmail.com
" Last Change: Thu  4 Sep 00:26:36 EEST 2014
" vim: set sw=4 sts=4:

" You can format all files in a directory easily with
" find -name '*.jape' -exec vim {} -c 'normal gg=GZZ' \;
" SO AWESOME

if exists("b:did_indent")
    finish
endif
let b:did_indent = 1

setlocal autoindent smartindent
setlocal indentexpr=GetJapeIndent()
setlocal indentkeys+=0],0)

if exists("*GetJapeIndent")
    finish
endif


function! s:OpenBrace(lnum)
    call cursor(a:lnum, 1)
    return searchpair('{\\|(', '', '}\|)', 'nbW')
endfunction

function! s:patternOr(...)
    let result = ''
    for p in a:000
        let result = result . p . '\|'
    endfor
    " remove the last \|
    return strpart(result, 0, strlen(result) - 2)
endfunction

" Match the following:
"')' - simple end of annotation or function call
"'}' - end of block
"')\s*?' - end of optional annotation
"')\s*:\s*\w\+' end of annotation with a binding
let s:closing_patterns = '^\s*\(' . s:patternOr('}', ')', ')\s*?', ')\s*:\s*\w\+') . '\)\s*'

function! GetJapeIndent()
    let pnum = prevnonblank(v:lnum - 1)
    if pnum == 0
       return 0
    endif

    let line = getline(v:lnum)
    let pline = getline(pnum)
    let ind = indent(pnum)

    " Don't indent comments
    " TODO: Handle multiline comments properly

    " Match opening brace "
    if pline =~ '\({\|\[\|(\|:\)\s*$'
        let ind += &sw
    " If we are in jape then we want patterns like the following
    " Macro: somemacro
    " (
    "   ( ({Token})?
    "     (Token) - mind the indention
    "   )
    " )
    " to work as expected
    elseif pline =~ '(\s*(' && synIDattr(synID(line('.'), 1, 0), 'name') == 'JapeMacro'
        let ind += &sw
    endif

    if line =~ s:closing_patterns
        let ind = indent(s:OpenBrace(v:lnum))
    endif

    " Don't actually shift over for "} else ..." and "} else if..."
    "if line =~ '\s*}\s*else'
        "let ind -= &sw
    "endif

    return ind
endfunction

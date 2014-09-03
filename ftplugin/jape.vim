let g:tagbar_type_jape = {
    \ 'ctagstype' : 'jape',
    \ 'kinds'     : [
        \ 'r:rule',
        \ 'm:macro',
    \ ]
\ }

vnoremap gj !astyle --style=java<CR>

set suffixesadd=.jape

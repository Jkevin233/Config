hi MDTask ctermfg=1
hi MDDoneText ctermfg=37 cterm=italic,strikethrough
hi MDTodoText cterm=NONE
hi MDDoneDate cterm=italic,strikethrough ctermfg=71
hi MDTodoDate ctermfg=71
au FileType markdown syn match markdownError "\w\@<=\w\@="
au FileType markdown syn match MDDoneDate /[SD]:\d\{4\}\([\/-]\d\d\)\{2\}/ contained
au FileType markdown syn match MDTodoDate /[SD]:\d\{4\}\([\/-]\d\d\)\{2\}/ contained
au FileType markdown syn match MDDoneText /- \[x\] \zs.*/ contains=MDDoneDate contained
au FileType markdown syn match MDTodoText /- \[ \] \zs.*/ contains=MDTodoDate contained
au FileType markdown syn match MDTask     /- \[\(x\| \)\] .*/ contains=MDDoneText,MDTodoText
au FileType markdown call matchadd('Todo', 'D:'.strftime("%Y-%m-%d"))

let b:md_block = '```'
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2
nnoremap <silent><buffer> <CR>   :call <SID>toggleTodoStatus()<CR><CR>
nnoremap <silent><buffer> <2-LeftMouse> :call <SID>toggleTodoStatus()<CR>:w<CR><2-LeftMouse>
autocmd Filetype markdown inoremap <buffer> ,f <Esc>/<++><CR>:nohlsearch<CR>"_c4l
autocmd Filetype markdown inoremap <buffer> <c-e> <Esc>/<++><CR>:nohlsearch<CR>"_c4l
autocmd Filetype markdown inoremap <buffer> ,w <Esc>/ <++><CR>:nohlsearch<CR>"_c5l<CR>
autocmd Filetype markdown inoremap <buffer> ,n ---<Enter><Enter>
autocmd Filetype markdown inoremap <buffer> ,b **** <++><Esc>F*hi
autocmd Filetype markdown inoremap <buffer> ,s ~~~~ <++><Esc>F~hi
autocmd Filetype markdown inoremap <buffer> ,i ** <++><Esc>F*i
autocmd Filetype markdown inoremap <buffer> ,d `` <++><Esc>F`i
autocmd Filetype markdown inoremap <buffer> ,c ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA
autocmd Filetype markdown inoremap <buffer> ,m - [ ] 
autocmd Filetype markdown inoremap <buffer> ,p ![](<++>) <++><Esc>F[a
autocmd Filetype markdown inoremap <buffer> ,a [](<++>) <++><Esc>F[a
autocmd Filetype markdown inoremap <buffer> ,1 #<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> ,2 ##<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> ,3 ###<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> ,4 ####<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> ,l --------<Enter>


fun! s:toggleTodoStatus()
    let line = getline('.')
    if line =~ glob2regpat('*- \[ \]*')
        call setline('.', substitute(line, '\[ \]', '[x]', ''))
    elseif line =~ glob2regpat('*- \[x\]*')
        call setline('.', substitute(line, '\[x\]', '[ ]', ''))
    endif
endf

nnoremap <silent><buffer> <F6> :call <SID>toggleMPTheme()<CR>
inoremap <silent><buffer> <F6> <ESC>:call <SID>toggleMPTheme()<CR>
fun! s:toggleMPTheme()
    if g:mkdp_theme == 'dark'
        let g:mkdp_theme = 'light'
    else
        let g:mkdp_theme = 'dark'
    endif

    exec 'MarkdownPreviewStop'
    sleep 1
    exec 'MarkdownPreview'
endf

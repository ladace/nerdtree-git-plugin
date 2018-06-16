function! s:checkout(node)
    if input("check out " . a:node.path.str() . " (Y/n)") ==# "Y"
        echo system('git checkout ' . a:node.path.str())
        call a:node.refresh()
        call b:NERDTree.render()
        redraw
    endif
endfunction

function! s:diff(node)
    echo system('git diff ' . a:node.path.str())
endfunction

function! s:gitAdd(node)
    call system('git add ' . a:node.path.str())
    call a:node.refresh()
    call b:NERDTree.render()
    redraw
endfunction

function! s:gitCommit(node)
    let l:message = input("commit message:")
    if strlen(l:message) != 0
        echo system('git commit -m "' . l:message . '"')
    else
        echo 'aborted'
    endif
endfunction

function s:SID()
  return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfun

let s:s = '<SNR>' . s:SID() . '_'

call NERDTreeAddKeyMap({
    \ 'key': '<C-g>c',
    \ 'scope': 'FileNode',
    \ 'callback': s:s.'checkout',
    \ 'quickhelpText': 'Git checkout the file' })

call NERDTreeAddKeyMap({
    \ 'key': '<C-g>d',
    \ 'scope': 'Node',
    \ 'callback': s:s.'diff',
    \ 'quickhelpText': 'Git diff the file' })

call NERDTreeAddKeyMap({
    \ 'key': '<C-g>a',
    \ 'scope': 'Node',
    \ 'callback': s:s.'gitAdd',
    \ 'quickhelpText': 'Git add the file' })

call NERDTreeAddKeyMap({
    \ 'key': '<C-g>m',
    \ 'scope': 'Node',
    \ 'callback': s:s.'gitCommit',
    \ 'quickhelpText': 'Git commit staged changes' })


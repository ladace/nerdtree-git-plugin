function! s:checkout(node)
    if input("check out " . a:node.path.str() . " (Y/n)") == "Y"
        call system('git checkout ' . a:node.path.str())
        call a:node.refresh()
        call b:NERDTree.render()
        redraw
    endif
endfunction

function! s:diff(node)
    echo system('git diff ' . a:node.path.str())
endfunction

function s:SID()
  return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfun

let s:s = '<SNR>' . s:SID() . '_'

call NERDTreeAddKeyMap({
    \ 'key': '<C-g>c',
    \ 'scope': 'FileNode',
    \ 'callback': s:s.'checkout',
    \ 'quickhelpText': 'Check out the file' })

call NERDTreeAddKeyMap({
    \ 'key': '<C-g>d',
    \ 'scope': 'Node',
    \ 'callback': s:s.'diff',
    \ 'quickhelpText': 'Diff the file' })

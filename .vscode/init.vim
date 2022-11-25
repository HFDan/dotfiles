nnoremap <Space>a <Cmd>call VSCodeNotify('editor.action.quickFix')<CR>
nnoremap <Space>/ <Cmd>call VSCodeNotify('editor.action.commentLine')<CR>
vnoremap <Space>/ <Cmd>call VSCodeNotify('editor.action.blockComment')<CR>
nnoremap <Space>bp <Cmd> call VSCodeNotify('editor.debug.action.toggleBreakpoint')<CR>
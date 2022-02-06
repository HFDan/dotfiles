set tabstop=4
set number
set softtabstop noexpandtab
set shiftwidth=4
set termguicolors


call plug#begin()
	
	Plug 'itchyny/lightline.vim'
	Plug 'neoclide/coc.nvim', { 'branch': 'release' }
	Plug 'doums/darcula'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
	Plug 'Pocco81/AutoSave.nvim'
	Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}

call plug#end()

colorscheme darcula

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
      \ 'colorscheme': 'darculaOriginal',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction'
      \ },
      \ }

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = ''

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = ''

" Use ctrl - space to trigger completion.
if has('nvim')
  inoremap <silent><expr> <C-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

inoremap <silent><nowait><expr> <Tab>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#jumpable() ? "\<C-R>=coc#rpc#request('snippetNext', [])<cr>" :
      \ coc#expandable() ? "\<C-R>=coc#rpc#request('doKeymap', ['snippets-expand',''])<CR>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <silent><expr> <S-TAB>
      \ coc#jumpable() ? "\<C-R>=coc#rpc#request('snippetPrev', [])<cr>" :
      \ "\<C-d>"

snoremap <buffer><nowait><silent><TAB> <Esc>:call coc#rpc#request('snippetNext', [])<cr>
snoremap <buffer><nowait><silent><S-TAB> <Esc>:call coc#rpc#request('snippetPrev', [])<cr>

" functions
" tab behavior
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)


nnoremap ex <cmd>CHADopen<cr>

lua << EOF
autosave = require("autosave")


autosave.setup(
    {
        enabled = true,
        execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
        events = {"InsertLeave", "TextChanged"},
        conditions = {
            exists = true,
            filename_is_not = {},
            filetype_is_not = {},
            modifiable = true
        },
        write_all_buffers = false,
        on_off_commands = true,
        clean_command_line_interval = 0,
        debounce_delay = 135
    }
)
EOF


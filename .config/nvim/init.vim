set tabstop=4
set number
set softtabstop noexpandtab
set shiftwidth=4
set termguicolors
filetype plugin on
set nowrap

call plug#begin()
	
	Plug 'itchyny/lightline.vim'
	Plug 'neoclide/coc.nvim', { 'branch': 'release' }
	Plug 'doums/darcula'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
	Plug 'Pocco81/AutoSave.nvim'
	Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'jiangmiao/auto-pairs'
	Plug 'machakann/vim-sandwich'
	Plug 'preservim/nerdcommenter'
	Plug 'mfussenegger/nvim-dap'
	Plug 'rcarriga/nvim-dap-ui'
	Plug 'theHamsta/nvim-dap-virtual-text'
	Plug 'Mofiqul/vscode.nvim'
	Plug 'emilienlemaire/clang-tidy.nvim'
	Plug 'paretje/nvim-man'

call plug#end()

let g:vscode_style = "dark"
let g:vscode_transparency = 1
let g:vscode_italic_comment = 1
let g:coc_default_semantic_highlight_groups = 1
colorscheme vscode

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
	  \ 'colorscheme': 'powerline',
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

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Remap for do codeAction of current line
nmap <silent> ca <cmd>CocAction<CR>

let cocpmenuwinid = call popup_menu(a:items, {
     \ 'title': a:title,
     \ 'filter': function('s:QuickpickFilter'),
     \ 'callback': function('s:QuickpickHandler'),
     \ })

call setbufvar(winbufnr(cocpmenuwinid), '&filetype', 'cocpmenu')``

redraw

" CHADtree
nnoremap ex <cmd>CHADopen<cr>

" Telescope
nnoremap <C-f> <cmd>Telescope live_grep<cr>

" NerdCommenter
nnoremap <C-_> <cmd>call NERDComment(0, "toggle")<CR>
inoremap <C-_> <C-o> <cmd>call NERDComment(0, "toggle")<CR>
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv

" Debugger
nnoremap <silent> bp <cmd>lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <F9> <cmd>lua require'dap'.continue()<CR>
nnoremap <silent> <F8> <cmd>lua require'dap'.step_over()<CR>
nnoremap <silent> <F7> <cmd>lua require'dap'.step_into()<CR>
nnoremap <silent> <F6> <cmd>lua require'dap'.repl.open()<CR>

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

local dap = require("dap")

dap.adapters.lldb = {
		type = 'executable',
		command = '/usr/bin/lldb-vscode',
		name = 'lldb'
}

dap.configurations.cpp = {
	{
	name = "Launch",
	type = "lldb",
	request = "launch",
	program = function()
		return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
	end,
	cwd = '${workspaceFolder}',
	stopOnEntry = false,
	args = {},
	runInTerminal = false,
	},
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

dap.adapters.netcoredbg = {
	type = 'executable',
	command = '/usr/bin/netcoredbg',
	args = {'--interpreter=vscode'}
}

dap.configurations.cs = {
  {
    type = "netcoredbg",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
        return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end,
  },
}

dap.adapters.python = {
	type = "executable",
	command = '/usr/bin/python3',
	args = {"-m", "debugpy.adapter"}
}

require("nvim-dap-virtual-text").setup()

require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  --ensure_installed = "maintained",

  -- Install languages synchronously (only applied to `ensure_installed`)
  --sync_install = false,

  -- List of parsers to ignore installing
  --ignore_install = { "javascript" },

  highlight = {
    -- `false` will disable the whole extension
    enable = false,

    -- list of language that will be disabled
   -- disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
	-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    -- additional_vim_regex_highlighting = false,
  },
}

EOF


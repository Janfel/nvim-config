" set number relativenumber
set mouse=a
set number

filetype plugin indent on

set tabstop=8 " Display tabs with width 8.
set softtabstop=4 " Insert 4 spaces for a tab.
set shiftwidth=4 " When indenting with '>', use 4 spaces width.
set expandtab " Insert spaces when TAB is pressed.
set showcmd " Show the current command in the bottom right.
set visualbell " Disable beeping.
set smartcase " Smart-case searching.
set confirm " Confirmation dialogues
set list " Show tab characters
set foldmethod=marker " Recognize folding marks.

if (has("termguicolors"))
	set termguicolors
endif

function UseTabs()
	let &tabstop = &shiftwidth
	set softtabstop=0
	set noexpandtab
endfunction
command! UseTabs call UseTabs()

function UseSpaces()
	let &softtabstop = &shiftwidth
	set tabstop=8
	set expandtab
endfunction
command! UseSpaces call UseSpaces()

let g:mapleader = "\<Space>"
let g:maplocalleader = ','

if !exists('g:vscode')
	" Needs WhichKey.
	nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
	nnoremap <silent> <localleader> :<c-u>WhichKey ','<CR>
endif

if exists('g:vscode')
	nnoremap <silent> <leader><Space> <Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>
	nnoremap <silent> <leader>:       <Cmd>call VSCodeNotify('workbench.action.showCommands')<CR>
endif

command! Config edit ~/.config/nvim/init.vim

noremap <F3> :Autoformat<CR>

nnoremap <C-s> :w<CR>
inoremap <C-s> <C-o>:w<CR>
vnoremap <C-s> <C-c>:w<CR>gv

nnoremap U <C-r>

nnoremap <silent> <Leader>r :!"%:p"<CR>
inoremap <silent> <C-x> <Esc>:w<CR>:!"%:p"<CR>

if exists('g:vscode')
	" Stolen from https://github.com/vscode-neovim/vscode-neovim/pull/502#issuecomment-831682643.
	nnoremap <silent> za <Cmd>call VSCodeNotify('editor.toggleFold')<CR>
	nnoremap <silent> zR <Cmd>call VSCodeNotify('editor.unfoldAll')<CR>
	nnoremap <silent> zM <Cmd>call VSCodeNotify('editor.foldAll')<CR>
	nnoremap <silent> zo <Cmd>call VSCodeNotify('editor.unfold')<CR>
	nnoremap <silent> zO <Cmd>call VSCodeNotify('editor.unfoldRecursively')<CR>
	nnoremap <silent> zc <Cmd>call VSCodeNotify('editor.fold')<CR>
	nnoremap <silent> zC <Cmd>call VSCodeNotify('editor.foldRecursively')<CR>

	nnoremap <silent> z1 <Cmd>call VSCodeNotify('editor.foldLevel1')<CR>
	nnoremap <silent> z2 <Cmd>call VSCodeNotify('editor.foldLevel2')<CR>
	nnoremap <silent> z3 <Cmd>call VSCodeNotify('editor.foldLevel3')<CR>
	nnoremap <silent> z4 <Cmd>call VSCodeNotify('editor.foldLevel4')<CR>
	nnoremap <silent> z5 <Cmd>call VSCodeNotify('editor.foldLevel5')<CR>
	nnoremap <silent> z6 <Cmd>call VSCodeNotify('editor.foldLevel6')<CR>
	nnoremap <silent> z7 <Cmd>call VSCodeNotify('editor.foldLevel7')<CR>

	xnoremap <silent> zV <Cmd>call VSCodeNotify('editor.foldAllExcept')<CR>
endif

if !exists('g:vscode')

cabbrev h vertical botright help

call plug#begin()

" Languages
Plug 'sheerun/vim-polyglot'
"Plug 'dag/vim-fish'
"Plug 'cespare/vim-toml'
"Plug 'vim-ruby/vim-ruby'
"Plug 'vim-perl/vim-perl'
"Plug 'ziglang/zig.vim'

" Functionality
"Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-endwise'
Plug 'Townk/vim-autoclose'
Plug 'vim-scripts/HTML-AutoCloseTag'
Plug 'editorconfig/editorconfig-vim'
Plug 'preservim/nerdcommenter'

" Article
Plug 'airblade/vim-gitgutter'
"Plug 'editorconfig/editorconfig-vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'
"Plug 'mattn/emmet-vim'
"Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'dense-analysis/ale'

"Plug 'ervandew/supertab'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'liuchengxu/vim-which-key'
Plug 'Chiel92/vim-autoformat'

" CoC
"Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Themes
Plug 'joshdick/onedark.vim'

call plug#end()

let g:airline_theme = 'onedark'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

let g:lightline = {}
let g:lightline.colorscheme = 'one'
let g:lightline.separator = {'left': '', 'right': ''}
let g:lightline.subseparator = {'left': '', 'right': ''}

" Disabled temporarily until msgpack 1.0.0 is in the repos.
" let g:deoplete#enable_at_startup = 1


set background=dark
colorscheme onedark

endif

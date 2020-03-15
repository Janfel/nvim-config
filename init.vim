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

if (has("termguicolors"))
    set termguicolors
endif

let g:mapleader = "\<Space>"
let g:maplocalleader = ','
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

command Config edit ~/.config/nvim/init.vim

noremap <F3> :Autoformat<CR>

nnoremap <C-s> :w<CR>
inoremap <C-s> <C-o>:w<CR>
vnoremap <C-s> <C-c>:w<CR>gv

nnoremap <silent> <Leader>r :!"%:p"<CR>
inoremap <silent> <C-x> <Esc>:w<CR>:!"%:p"<CR>

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

" vimrc

set nocompatible
set expandtab
set shiftwidth=3
set tabstop=3
set autoindent
set smartindent

set ttyfast
set lazyredraw
set hlsearch

filetype on

" COLORS
syntax on
set t_Co=256
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
set termguicolors
"if exists('+termguicolors')
"  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"  set termguicolors
"endif
" ==


set ignorecase

set number

set ruler
set relativenumber


set laststatus=2

set showmode
set showcmd

set cursorline

set listchars=tab:▸\ ,eol:¬


" STATUS LINE ------------------------------------------------------------ {{{

" Clear status line when vimrc is reloaded.
set statusline=

" Status line left side.
set statusline+=\ %F\ %M\ %Y\ %R

" Use a divider to separate the left side from the right side.
set statusline+=%=

" Status line right side.
set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%

" Show the status on the second to last line.
set laststatus=2

" }}}

call plug#begin()
Plug 'morhetz/gruvbox'

call plug#end()


" This file uses a lot of random stuff from vim-sensible

"		--- PLUGINS ---
call plug#begin()
Plug 'ycm-core/YouCompleteMe'

Plug 'tpope/vim-fugitive'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
call plug#end()


"		--- PLUGIN vimrc stuff ---
" vim-airline font fix
let g:airline_powerline_fonts = 1


"		--- Custom functions ---
" diff current buffer with saved
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()


"		--- SETTINGS ---
" colorscheme
colorscheme molokai
let g:rehash256 = 1

" line numbers
set nu
set relativenumber
" line ruler
set colorcolumn=100

" tab size
set tabstop=4
" Shift-> and Shift-< size
set shiftwidth=4
" spaces instead of tabs
" set expandtab

" automatically read file if changed outside of vim
set autoread
" always show statusbar
set laststatus=2
" use current indentation when creating a new line
set autoindent
" fix backspace
set backspace=indent,eol,start
" see wildmenu (eg: using :!)
set wildmenu
" replaces longline characters with @@@ on last columns
set display+=lastline

" increase history to 1000
if &history < 1000
  set history=1000
endif

" increase maxtabs to 50
if &tabpagemax < 50
  set tabpagemax=50
endif

" always have at least 1 line above/below cursor
if !&scrolloff
  set scrolloff=1
endif
"always have at least 5 characters on the left/right of cursor
if !&sidescrolloff
  set sidescrolloff=5
endif

" incremental search
set incsearch
set hlsearch
" ignorescase by default but will search case-sensitive if contains capital
" letters
set ignorecase
set smartcase
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" Delete comment character when joining commented lines
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j
endif


"		--- VIM CONFIG ---
" changes encoding to utf-8 if possible
if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif

" indentation file extension config
if has('autocmd')
  filetype plugin indent on
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" random mapping protections or something?
if empty(mapcheck('<C-U>', 'i'))
  inoremap <C-U> <C-G>u<C-U>
endif
if empty(mapcheck('<C-W>', 'i'))
  inoremap <C-W> <C-G>u<C-W>
endif


"		--- UNSORTED RANDOM STUFF---
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

if !empty(&viminfo)
  set viminfo^=!
endif

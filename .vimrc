set backspace=indent,eol,start
set shiftwidth=4
set softtabstop=4
set switchbuf=usetab,useopen
set wildchar=<Tab> wildmenu wildmode=full
set ttimeoutlen=50

set visualbell
set noshowmode
set number
set nomodeline

set ignorecase
set laststatus=2
set background=dark
set shell=bash\ -l

" Do not clear screen on exit
set t_ti= t_te=

" Unset the last search pattern register by hitting return
nnoremap <CR> :noh<CR><CR>

" Kill matching paren
let loaded_matchparen=1

silent! colo benokai

" Pane navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


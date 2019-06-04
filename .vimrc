set shiftwidth=2
set softtabstop=2
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

" Set tab width to 8 spaces for C/C++
autocmd FileType c* setlocal shiftwidth=4
autocmd FileType c* setlocal softtabstop=4
autocmd FileType py setlocal shiftwidth=4
autocmd FileType py setlocal softtabstop=4

" Do not clear screen on exit
set t_ti= t_te=

"Unset the last search pattern register by hitting return
nnoremap <CR> :noh<CR><CR>

" Kill matching paren
let loaded_matchparen=1

call plug#begin('~/.vim/plugged')
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'flazz/vim-colorschemes'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'godlygeek/tabular'
Plug 'bronson/vim-trailing-whitespace'
Plug 'Raimondi/delimitMate'
call plug#end()

silent! colo benokai

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Pane navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>
let g:NERDSpaceDelims=1
let g:NERDDefaultAlign='left'

" CtrlP
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
nnoremap <leader>cp :CtrlPClearCache<CR>

" DelimitMate
let delimitMate_expand_cr=1

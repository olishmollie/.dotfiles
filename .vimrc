set shiftwidth=2
set softtabstop=2
set switchbuf=usetab,useopen
set wildchar=<Tab> wildmenu wildmode=full
set ttimeoutlen=50
set visualbell
set noshowmode
set number
set noic

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

" Kill matching paren
let loaded_matchparen=1

call plug#begin('~/.vim/plugged')
Plug 'craigemery/vim-autotag'
Plug 'ajh17/VimCompletesMe'
Plug 'flazz/vim-colorschemes'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'itchyny/lightline.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'godlygeek/tabular'
Plug 'bronson/vim-trailing-whitespace'
Plug 'isruslan/vim-es6'
Plug 'leafgarland/typescript-vim'
Plug 'keith/swift.vim'
Plug 'Raimondi/delimitMate'
Plug 'vim-syntastic/syntastic'
call plug#end()

silent! colo obsidian

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Pane navigation (if no tmux)
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

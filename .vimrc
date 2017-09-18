set expandtab
set shiftwidth=2
set softtabstop=2
set switchbuf=usetab,useopen
set wildchar=<Tab> wildmenu wildmode=full
set ttimeoutlen=50
set visualbell
set noshowmode

set ignorecase
set laststatus=2
set background=dark
set shell=bash\ -l

" Do not clear screen on exit
set t_ti= t_te=

" Kill matching paren
let loaded_matchparen=1

call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'itchyny/lightline.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'honza/vim-snippets'
Plug 'godlygeek/tabular'
Plug 'leafgarland/typescript-vim'
Plug 'Raimondi/delimitMate'
call plug#end()

" Pane navigation (if no tmux)
" nnoremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>

" Syntastic
let g:syntastic_mode_map = {
  \ "mode": "active",
  \ "passive_filetypes": ["html"] }

" YouCompleteMe
" nnoremap <leader>jd :YcmCompleter GoToDefinition<CR>
" nnoremap <leader>rn :YcmCompleter RefactorRename 

" NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>
let g:NERDSpaceDelims=1
let g:NERDDefaultAlign='left'

" CtrlP
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
nnoremap <leader>cp :CtrlPClearCache<CR>

" Lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'warningCount', 'errorCount' ] ] 
      \ },
      \ 'component_expand': {
      \   'errorCount': 'ErrorCount',
      \   'warningCount': 'WarningCount'
      \ },
      \ 'component_type': {
      \   'errorCount': 'error',
      \   'warningCount': 'warning'
      \ }
      \ }

function! ErrorCount() abort
  let errorCount = youcompleteme#GetErrorCount()
  return "✗ " . string(errorCount)
endfunction

function! WarningCount() abort
  let warningCount = youcompleteme#GetWarningCount()
  return "▲ " . string(warningCount)
endfunction

autocmd CursorMoved * call lightline#update()

" DelimitMate
let delimitMate_expand_cr=1

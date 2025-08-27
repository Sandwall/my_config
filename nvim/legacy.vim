" syntax highlighting
syntax on
filetype plugin indent on

" numbered lines
set number
set relativenumber

" Visual tab changes
:set tabstop=4
:set shiftwidth=4

" change tabs to 4 spaces
":set expandtab

" autoread on change
set autoread

" turn on rainbow
let g:rainbow_active = 1

" turn on better whitespace
let g:better_whitespace_enabled = 1

" open FZF on directory open
autocmd VimEnter * if isdirectory(expand("<amatch>")) | exe 'FZF! '.expand("<amatch>") | endif

" C-p: FZF find files
nnoremap <silent> <C-p> :Files<CR>

" C-g: FZF ('g'rep)/find in files
nnoremap <silent> <C-g> :Rg<CR>


set autoindent
set colorcolumn=81 " one more than textwidth
set copyindent
set cursorline
set expandtab
set foldmethod=syntax
set formatoptions+=cro
set history=9999
set hlsearch
set incsearch
set laststatus=2 " always show status line
set linebreak
set mouse=a
set number
set scrolloff=10
set shiftround
set shiftwidth=2
set showmatch
set smarttab
set tabpagemax=50
set tabstop=2
set undolevels=9999
set virtualedit=block
set visualbell
set wildignore=*.swp,*.bak,*.pyc,*.class
set winminheight=0

" http://jeffkreeftmeijer.com/2012/relative-line-numbers-in-vim-for-super-fast-movement/
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>
autocmd FocusLost   * :set number
autocmd FocusGained * :set relativenumber
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

" Get rid of an unnecessary shift
noremap ; :

" Quickly change from pane to pane
tnoremap <A-Left> <C-\><C-n><C-w>h
tnoremap <A-Down> <C-\><C-n><C-w>j
tnoremap <A-Up> <C-\><C-n><C-w>k
tnoremap <A-Right> <C-\><C-n><C-w>l
noremap <A-Left> <C-w>h
noremap <A-Down> <C-w>j
noremap <A-Up> <C-w>k
noremap <A-Right> <C-w>l
inoremap <A-Left> <Esc><C-w>h
inoremap <A-Down> <Esc><C-w>j
inoremap <A-Up> <Esc><C-w>k
inoremap <A-Right> <Esc><C-w>l

" Remap Leader to comma, easy to reach
let mapleader=","

" Clear search highlights
nmap <silent> <Leader>/ :nohlsearch<CR>

" Create an easier mapping for getting out of terminal mode
" https://vi.stackexchange.com/a/6966
tnoremap <Leader>. <C-\><C-n>

" Quickly create a new terminal in a new tab
tnoremap <Leader>c <C-\><C-n>:tab new<CR>:term<CR>
noremap <Leader>c :tab new<CR>:term<CR>
"inoremap <Leader>c <Esc>:tab new<CR>:term<CR>

" Quickly create a new terminal in a vertical split
tnoremap <Leader>% <C-\><C-n>:vsp<CR><C-w><C-w>:term<CR>
noremap <Leader>% :vsp<CR><C-w><C-w>:term<CR>
"inoremap <Leader>% <Esc>:vsp<CR><C-w><C-w>:term<CR>

" Quickly create a new terminal in a horizontal split
tnoremap <Leader>" <C-\><C-n>:sp<CR><C-w><C-w>:term<CR>
noremap <Leader>" :sp<CR><C-w><C-w>:term<CR>
"inoremap <Leader>" <Esc>:sp<CR><C-w><C-w>:term<CR>

" BASIC SETTINGS BEGIN

set nocompatible

set backspace=indent,eol,start " backspace everything
set number " enable line numbering
set noerrorbells " disable beeps
set title " show the current filename in the window title
set cursorline " highlight current line
" remove underline
hi CursorLine cterm=none
set wildmenu " visual autocomplete for commands
set wildignore=*.swp " ignore list for wildmenu
set lazyredraw " optimize for drawing speed
set showmatch " highlight brackets matches
set incsearch " search as characters are entered
set hlsearch " highlight search matches
set nobackup " disable native backups
set noswapfile " disable swap files
set mouse=a " enable mouse (yeah, I'm a fucking newbie)
set showtabline=2 " always show tabline
" Make line numbers distinct from code
hi LineNr ctermfg=grey ctermbg=black

" Enable bi-directional integration with the OS clipboard
set clipboard=unnamedplus

" Tabs settings
set tabstop=4 " Show 4 spaces per <TAB>
set softtabstop=4
set expandtab " convert tabs to spaces

" Customize netrw
let g:netrw_winsize = 25 " width of vertical split
let g:netrw_list_hide = &wildignore " use ignorelist

" Custom mappings
" disable search highlight when , is pressed
nnoremap <leader><space> :nohlsearch<CR>
" easier window navigation
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

" BASIC SETTINGS END

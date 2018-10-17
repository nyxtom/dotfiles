"============================================
"         VIM 8+ Default Behavior
"===========================================

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" Avoid side effects when it was already reset.
if &compatible
  set nocompatible
endif

" When the +eval feature is missing, the set command above will be skipped.
" Use a trick to reset compatible only when the +eval feature is missing.
silent! while 0
  set nocompatible
silent! endwhile

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

set history=200		" keep 200 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set wildmenu		" display completion matches in a status line

set ttimeout		" time out for key codes
set ttimeoutlen=100	" wait up to 100ms after Esc for special key

" Show @@@ in the last line if it is truncated.
set display=truncate

" Show a few lines of context around the cursor.  Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=5

" Do incremental searching when it's possible to timeout.
if has('reltime')
  set incsearch
endif

" Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it
" confusing.
set nrformats-=octal " (default) vim 8+

" Don't use Ex mode, use Q for formatting.
" Revert with ":unmap Q".
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine.  By enabling it you
" can position the cursor, Visually select and scroll with the mouse.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on when the terminal has colors or when using the
" GUI (which always has colors).
if &t_Co > 2 || has("gui_running")
  " Revert with ":syntax off".
  syntax on

  " I like highlighting strings inside C comments.
  " Revert with ":unlet c_comment_strings".
  let c_comment_strings=1
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  " Revert with ":filetype off".
  filetype plugin indent on

  " Put these in an autocmd group, so that you can revert them with:
  " ":augroup vimStartup | au! | augroup END"
  augroup vimStartup
    au!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid, when inside an event handler
    " (happens when dropping a file on gvim) and for a commit message (it's
    " likely a different one than last time).
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

  augroup END

endif " has("autocmd")


"=============================================
"            Plugins using vundle
"=============================================

set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=/usr/local/opt/fzf
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" ------ Plugins -------
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Plugin 'Raimondi/delimitMate'
Plugin 'Yggdroot/indentLine'

" fzf+ripgrep in bashrc for insanely awesome search
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

" Zen mode
Plugin 'junegunn/goyo.vim'
Plugin 'amix/vim-zenroom2'

" Color Themes
Plugin 'flazz/vim-colorschemes'

call vundle#end()
colorscheme 1989

"=============================================
" sensible.vim/vim-sublime additional defaults
"=============================================

set sidescroll=1
set autoindent
set complete-=i
set showmatch
set showmode
set smarttab
set shiftround

" Use <C-L> to clear highlighting of :set hlsearch
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

set laststatus=2
set autoread

set encoding=utf-8

set tabstop=4 shiftwidth=4 expandtab

set number
set hlsearch
set ignorecase
set smartcase

set paste

set hidden

set nobackup
set nowritebackup
set noswapfile
set clipboard=unnamed

" Prefer unix fileformat defaults
set fileformats=unix,dos,mac

set completeopt=menuone,longest,preview

"=============================================
"         Grouped Behavior Settings
"=============================================

" Exit editing mode with ctrl+c
inoremap <C-c> <Esc>

" -- Mapping Default leader/command
map \ :
let mapleader = ','

" -- Tab behavior
nnoremap <C-b> :tabprevious<CR>
inoremap <C-b> <Esc>:tabprevious<CR>i
nnoremap <C-n> :tabnext<CR>
inoremap <C-n> <Esc>:tabnext<CR>i
nnoremap <C-t> :tabnew<CR>
inoremap <C-t> <Esc>:tabnew<CR>i
nnoremap <C-k> :tabclose<CR>
inoremap <C-k> <Esc>:tabclose<CR>i

" -- Number/Toggle
nnoremap <Leader>1 :set number<CR>
nnoremap <Leader>0 :set nonumber<CR>

"=============================================
"         Plugin Configuration
"=============================================

" -- scrooloose/nerdtree
nnoremap <C-\> :NERDTreeToggle<CR>

" -- vim-airline/vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='badwolf'

" -- airblade/vim-gitgutter
nnoremap <Leader>g :GitGutterToggle<CR>

" -- Yggdroot/indentLine
let g:indentLine_setColors = 220
let g:indentLine_enabled = 1

" -- amix/vim-zenroom2
nnoremap <silent> <leader>z :Goyo<cr>

" -- junegunn/fzf
nnoremap <C-p> :FZF<CR>

command! -bang -nargs=* File
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

nnoremap <Leader>f :File<CR>

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

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

set rtp+=/usr/local/opt/fzf
call plug#begin('~/.vim/plugged')

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

" ------ Plugins -------

Plug 'airblade/vim-gitgutter'
" Plug 'tpope/vim-fugitive'
" Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'Yggdroot/indentLine'

Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'ternjs/tern_for_vim', { 'do': 'npm install && npm install --g tern' }
Plug 'carlitux/deoplete-ternjs', { 'on_ft': 'javascript' }
Plug 'jiangmiao/auto-pairs'
" Plug 'ujihisa/neco-look'
Plug 'othree/yajs.vim'
Plug 'heavenshell/vim-jsdoc'
Plug 'Quramy/vison'
Plug 'othree/jspc.vim'
Plug 'ntpeters/vim-better-whitespace'

" navigation/utils
Plug 'terryma/vim-multiple-cursors'
Plug 'christoomey/vim-tmux-navigator'

" Zen mode
Plug 'junegunn/goyo.vim'
Plug 'amix/vim-zenroom2'

" fzf+ripgrep in bashrc for insanely awesome search
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Color Themes
Plug 'NLKNguyen/papercolor-theme'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'sheerun/vim-polyglot'
Plug 'trevordmiller/nova-vim'
Plug 'miyakogi/seiya.vim'

call plug#end()

" =============================================
"                colors/theming
" =============================================
set termguicolors
if &term =~# '^screen'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
highlight pmenu guibg=#666666 ctermbg=6 ctermfg=0
highlight pmenusel guibg=#333333 ctermbg=4 ctermfg=7
let g:nova_transparent = 1
colorscheme nova

"=============================================
" sensible.vim/vim-sublime additional defaults
"=============================================

set sidescroll=1
set autoindent
set complete-=i
set showmatch
set showmode
set smarttab
set breakindent
set showbreak=↪\
set linebreak
set shiftround

" Use <C-f> to clear highlighting of :set hlsearch
if maparg('<C-f>', 'n') ==# ''
  nnoremap <silent> <C-f> :nohlsearch<CR><C-L>
endif

set laststatus=2
set autoread

set encoding=UTF-8

set tabstop=4 shiftwidth=4 expandtab

set number
set hlsearch
set ignorecase
set smartcase

set hidden

set nobackup
set nowritebackup
set noswapfile
set clipboard=unnamed

" Prefer unix fileformat defaults
set fileformats=unix,dos,mac

set splitbelow
set completeopt+=longest,menuone,noinsert,noselect
set completeopt-=preview
inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"

"=============================================
"         grouped behavior settings
"=============================================

" exit editing mode with ctrl+c
inoremap <c-c> <esc>

" -- mapping default leader/command
map \ :
let mapleader = ','

" -- buffer navigation / tmux
nnoremap <c-u> :bprevious<cr>
nnoremap <C-i> :bnext<CR>
nnoremap <C-d> :bdelete<CR>
nnoremap <leader>w :split<CR>
nnoremap <leader>W :vsplit<CR>

" -- saving
map <leader>s :w<CR>
nmap <leader>Q :q<CR>

"=============================================
"         Plugin Configuration
"=============================================

" -- tmux
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-j> :TmuxNavigateDown<CR>
nnoremap <silent> <C-k> :TmuxNavigateUp<CR>
nnoremap <silent> <C-l> :TmuxNavigateRight<CR>
nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <C-;> :TmuxNavigatePrevious<CR>
tmap <C-j> <C-\><C-n>:TmuxNavigateDown<CR>
tmap <C-k> <C-\><C-n>:TmuxNavigateUp<CR>
tmap <C-l> <C-\><C-n>:TmuxNavigateRight<CR>
tmap <C-h> <C-\><C-n>:TmuxNavigateLeft<CR>
tmap <C-;> <C-\><C-n>:TmuxNavigatePrevious<CR>

" -- terminal mode
let g:term_buf = 0
function! Term_toggle()
  if g:term_buf == bufnr("term_buf")
    setlocal bufhidden=hide
    close
  else
    bottomleft vnew
    try
      exec "buffer ".g:term_buf
    catch
      call termopen("bash", {"detach": 0})
      let g:term_buf = bufnr("term_buf")
    endtry
  endif
endfunction
nnoremap <leader>` :call Term_toggle()<CR>

" -- scrooloose/nerdtree
nmap <C-\> :NERDTreeToggle<CR>
nnoremap <leader>r :NERDTreeFind<CR>
let g:NERDTreeMouseMode = 3

" -- vim-airline/vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='papercolor'

" -- airblade/vim-gitgutter
nnoremap <Leader>g :GitGutterToggle<CR>

" -- Yggdroot/indentLine
let g:indentLine_setColors = 220
let g:indentLine_enabled = 1

" -- amix/vim-zenroom2
nnoremap <silent> <leader>z :Goyo<cr>

" -- supertab
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
let g:SuperTabClosePreviewOnPopupClose = 1

" -- omni complete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#max_abbr_width = 0
let g:deoplete#max_menu_width = 0

" -- javascript
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_input_description = 1
let g:jsdoc_return = 0
let g:jsdoc_return_type = 0
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]
let g:tern_map_keys = 1
let g:vim_json_syntax_conceal = 0

" -- better-whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

" -- junegunn/fzf
command! -bang -nargs=* File
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

nnoremap <Leader>f :File<CR>

nnoremap <C-p> :FZF<CR>
" Files + devicons
function! Fzf_dev()
  let l:fzf_files_options = '--preview "rougify {2..} | head -'.&lines.'"'

  function! s:files()
    let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
    return s:prepend_icon(l:files)
  endfunction

  function! s:prepend_icon(candidates)
    let l:result = []
    for l:candidate in a:candidates
      let l:filename = fnamemodify(l:candidate, ':p:t')
      let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
      call add(l:result, printf('%s %s', l:icon, l:candidate))
    endfor

    return l:result
  endfunction

  function! s:edit_file(item)
    let l:pos = stridx(a:item, ' ')
    let l:file_path = a:item[pos+1:-1]
    execute 'silent e' l:file_path
  endfunction

  call fzf#run({
        \ 'source': <sid>files(),
        \ 'sink':   function('s:edit_file'),
        \ 'options': '-m ' . l:fzf_files_options,
        \ 'down':    '40%' })
endfunction

nnoremap <C-p> :call Fzf_dev()<CR>

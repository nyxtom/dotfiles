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
set lazyredraw

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

  augroup JsonToJsonc
      autocmd! FileType json set filetype=jsonc
  augroup END

endif " has("autocmd")

" =============================================
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

" Plug styled-components
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
" Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'jparise/vim-graphql'
" Plug 'wfxr/minimap.vim'
" Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'madox2/vim-ai'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'pangloss/vim-javascript'
Plug 'evanleck/vim-svelte'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'brooth/far.vim'
Plug 'svermeulen/vim-cutlass'
Plug 'mattn/webapi-vim'
Plug 'chazmcgarvey/zencoding-vim'
Plug 'puremourning/vimspector'
Plug 't9md/vim-choosewin'

Plug 'neoclide/coc.nvim'
Plug 'jiangmiao/auto-pairs'
" Plug 'ujihisa/neco-look'
Plug 'othree/yajs.vim'
Plug 'heavenshell/vim-jsdoc'
Plug 'Quramy/vison'
Plug 'othree/jspc.vim'

" navigation/utils
Plug 'terryma/vim-multiple-cursors'
Plug 'christoomey/vim-tmux-navigator'
Plug 'embear/vim-localvimrc'

" Zen mode
Plug 'junegunn/goyo.vim'
Plug 'amix/vim-zenroom2'

" fzf+ripgrep+ferret for insanely awesome search
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'wincent/ferret'

" Color Themes
Plug 'NLKNguyen/papercolor-theme'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'sheerun/vim-polyglot'
Plug 'trevordmiller/nova-vim'
Plug 'miyakogi/seiya.vim'
Plug 'jdkanani/vim-material-theme'
Plug 'hzchirs/vim-material'
Plug 'ayu-theme/ayu-vim'
Plug 'rainglow/vim'
Plug 'equt/paper.vim'
Plug 'arcticicestudio/nord-vim'

call plug#end()

" =============================================
"                colors/theming
" =============================================
"set termguicolors
if &term =~# '^screen'
   let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
   let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
highlight pmenu guibg=#666666 ctermbg=6 ctermfg=0
highlight pmenusel guibg=#333333 ctermbg=4 ctermfg=7
let g:nova_transparent = "NONE"

colorscheme nord

hi Normal guibg=NONE ctermbg=NONE
highlight VertSplit ctermbg=NONE guibg=NONE cterm=NONE ctermfg=238
hi SignColumn ctermbg=NONE guibg=NONE
hi Todo cterm=bold ctermfg=0 ctermbg=7 gui=bold guifg=Black guibg=LightGrey

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

set tabstop=2 shiftwidth=2 expandtab

set nonumber
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

" -- current file
nnoremap <leader>t :let @+= expand("%p")<cr>

" -- buffer navigation / tmux
nnoremap <c-u> :bprevious<cr>
nnoremap <C-i> :bnext<CR>
nnoremap <C-d> :bdelete<CR>
nnoremap <leader>d :bp<BAR>bd#<CR>
nnoremap <leader>w :split<CR>
nnoremap <leader>W :vsplit<CR>

" -- saving
map <leader>s :w<CR>
nmap <leader>Q :q<CR>

" -- prettier
map <leader>p :Prettier<CR>
nmap <leader>p :Prettier<CR>

" -- graphql
au BufNewFile,BufRead *.prisma setfiletype graphql

"=============================================
"         Plugin Configuration
"=============================================

" -- rustfmt
let g:rustfmt_autosave = 1
let g:rust_clip_command = 'pbcopy'

" -- minimap
let g:minimap_auto_start = 1
let g:minimap_auto_start_win_enter = 1

" -- choosewin
nmap - <Plug>(choosewin)

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
let g:NERDTreeShowHidden = 1
let g:NERDTreeWinSize=40
let g:NERDTreeWinPos = "left"

" -- clear cursor hold
autocmd CursorHold * echon ''

" -- fix syntax syncing
autocmd BufEnter * syntax sync fromstart

" -- vim-airline/vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='deus'
let g:airline#extensions#coc#enabled = 1

let s:hidden_all = 0
function! ToggleHiddenAll()
    if s:hidden_all == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
    :AirlineToggle
endfunction

nnoremap <silent> <S-h> :call ToggleHiddenAll()<CR>

" -- airblade/vim-gitgutter
nnoremap <silent> <Leader>g :GitGutterToggle<CR>

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
nnoremap <silent> <C-p> :Files<CR>

nnoremap <silent> <leader>e :call Fzf_dev()<CR>

" ripgrep
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

" Files + devicons
function! Fzf_dev()
  let l:fzf_files_options = '--preview "bat --style=numbers,changes --color always {1..-1} | head -'.&lines.'"'

  "function! s:files()
  "  let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
  "  return s:prepend_icon(l:files)
  "endfunction

  "function! s:prepend_icon(candidates)
  "  let l:result = []
  "  for l:candidate in a:candidates
  "    let l:filename = fnamemodify(l:candidate, ':p:t')
  "    "let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
  "    call add(l:result, printf('%s', l:candidate))
  "  endfor

  "  return l:result
  "endfunction

  function! s:edit_file(item)
    let l:pos = stridx(a:item, ' ')
    let l:file_path = a:item[pos+1:-1]
    execute 'silent e' l:file_path
  endfunction

  call fzf#run({
        \ 'sink': function('s:edit_file'),
        \ 'options': '-m ' . l:fzf_files_options,
        \ 'down':    '40%' })
endfunction

set conceallevel=0
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" -- coc
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" -- vimspector
let g:vimspector_enable_mappings = "VISUAL_STUDIO"

" -- remap paste to black hole register
xnoremap p "_dP
nnoremap m d
xnoremap m d
nnoremap mm dd
nnoremap M D

" -- COC Float Scroll
if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-g> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-g>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-g> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-g> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-g>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
 inoremap <silent><expr> <TAB>
       \ coc#pum#visible() ? coc#pum#next(1):
       \ CheckBackspace() ? "\<Tab>" :
       \ coc#refresh()
 inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif



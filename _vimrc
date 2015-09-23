set nocompatible
set backspace=indent,eol,start

" Add xptemplate global personal directory value
if has("unix")
  set runtimepath+=~/.vim/personal
endif

" Menus
" This must happen before the syntax system is enabled
set mousemodel=popup

" Better modes.  Remeber where we are, support yankring
" set viminfo=!,'100,\"100,:20,<50,s10,h,n~/.viminfo

" The modelines bit prevents some security exploits having to do with
" modelines in files.
set modelines=0

" Enable Syntax Colors
syntax on
colors anderson
set nocursorline
set nocursorcolumn
set ttyfast
" The PC is fast enough, do syntax highlight syncing from start
autocmd BufEnter * :syntax sync fromstart

source ~/.vim/autoload/pathogen.vim
execute pathogen#infect()
set runtimepath^=~/.vim/bundle/ctrlp.vim

" Don't write backup files or swap files
set nobackup
set noswapfile

" Remember cursor position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" enable automatic title setting for terminals
set title
set titleold="Terminal"
set titlestring=%F\ -\ Vim

" disable wrapping of long lines
set nowrap

" Pathogen
filetype off
call pathogen#infect()
call pathogen#helptags() " generate helptags for everything in 'runtimepath'
filetype plugin indent on

" sets leader to ',' and localleader to "\"
let mapleader=","
let maplocalleader="\\"

" activate a permanent ruler and disable Toolbar, and add line
" highlightng as well as numbers.
" And disable the sucking pydoc preview window for the omni completion
" also highlight current line and disable the blinking cursor.
set ruler
set guioptions-=T " Don't show window toolbar
set completeopt-=preview
set gcr=a:blinkon0

" customize the wildmenu
set wildmenu
set wildignore=*.dll,*.o,*.pyc,*.bak,*.exe,*.jpg,*.jpeg,*.png,*.gif,*$py.class,*.class
set wildmode=list:full

" change working directory automatically
" disabled for mapleader that makes this explicit
"" set autochdir

" quicker window switching
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" arrow keys move visible lines
inoremap <Down> <C-R>=pumvisible() ? "\<lt>Down>" : "\<lt>C-O>gj"<CR>
inoremap <Up> <C-R>=pumvisible() ? "\<lt>Up>" : "\<lt>C-O>gk"<CR>
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk

" Search fixes
" Lowercase is case insensitive, mixed case is case sensitive
set ignorecase
set smartcase
" And be global by default
set gdefault
" Highlighting and incremental search
set hlsearch
set incsearch
" hide matches on <leader>space
nnoremap <leader><space> :nohlsearch<cr>

" tab for brackets
nnoremap <tab> %
vnoremap <tab> %

" split edit vimrc
nnoremap <leader>ev <C-w><C-s><C-l>:e $MYVIMRC<CR>

" Remove trailing whitespace on <leader>S
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>

" Ack on <leader>a
nnoremap <leader>a :Ack


" <leader>v selects the just pasted text
nnoremap <leader>v V`]

" NERDtree on <leader>t
nnoremap N :NERDTreeToggle<CR>
let NERDTreeIgnore=['\~$', '\.pyc$', '\.pyo$', '\.class$', 'pip-log\.txt$', '\.o$']
let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$',  '\.bak$', '\~$']
let NERDTreeChDirMode=2 " CWD is changed whenever the tree root is changed

" Tab navigation
nnoremap <C-n> :tabnext<CR>
nnoremap <C-p> :tabprev<CR>

" QuickRun
nnoremap <C-r> :QuickRun<CR>

" Scratch
"nmap <leader><tab> :Sscratch<CR><C-W>x<C-J>

" Quit window on <leader>q
nnoremap <leader>q :q<CR>

" Copy to Lodgeit on ^d
nnoremap <leader>p :Lodgeit<CR>

" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

" Easy switching
nnoremap <leader>th :set ft=htmldjango<CR>
nnoremap <leader>tp :set ft=python<CR>
nnoremap <leader>tj :set ft=javascript<CR>
nnoremap <leader>tr :set ft=rst<CR>

" Command-T support
nnoremap <leader>o :CommandT<CR>

" toggle between number and relative number on ,l
nnoremap <leader>l :call ToggleRelativeAbsoluteNumber()<CR>
function! ToggleRelativeAbsoluteNumber()
  if &number
    set relativenumber
  else
    set number
  endif
endfunction

" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Make the command line two lines high and change the statusline display to
" something that looks useful.
set cmdheight=2
set laststatus=2
set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w\ (%{&ff})\ %{fugitive#statusline()}
set showcmd
set number

" Tab Settings
set smarttab
set tabstop=8

" GUI Tab settings
function! GuiTabLabel()
  let label = ''
  let buflist = tabpagebuflist(v:lnum)
  if exists('t:title')
    let label .= t:title . ' '
  endif
  let label .= '[' . bufname(buflist[tabpagewinnr(v:lnum) - 1]) . ']'
  for bufnr in buflist
    if getbufvar(bufnr, '&modified')
      let label .= '+'
      break
    endif
  endfor
  return label
endfunction
set guitablabel=%{GuiTabLabel()}

" utf-8 default encoding
set enc=utf-8

" prefer unix over windows over os9 formats
set fileformats=unix,dos,mac

" don't bell or blink
set noerrorbells
set vb t_vb=

" keep some more lines for scope
set scrolloff=5

" hide some files and remove stupid help
let g:netrw_list_hide='^\.,.\(pyc\|pyo\|o\)$'
map <leader>b :Explore!<CR>

" Split management
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>W <C-w>s
nnoremap <leader>s :new<CR>

" ; is an alias for :
"nnoremap ; :

" Get rid of help key mapping
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" map :BufClose to :bq and configure it to open a file browser on close
let g:BufClose_AltBuffer = '.'
cnoreabbr <expr> bq 'BufClose'

" python support
" --------------
"  don't highlight exceptions and builtins. I love to override them in local
"  scopes and it sucks ass if it's highlighted then. And for exceptions I
"  don't really want to have different colors for my own exceptions ;-)
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8
\ formatoptions+=croq softtabstop=4 ft=python.django
\ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
let python_highlight_all=1
let python_highlight_exceptions=0
let python_highlight_builtins=0
autocmd FileType pyrex setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 cinwords=if,elif,else,for,while,try,except,finally,def,class,with

" ruby support
" ------------
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" php support
" -----------
autocmd FileType php setlocal shiftwidth=8 tabstop=8 softtabstop=8
" cucumber support
" -----------
syntax on
au BufNewFile,BufRead *.feature set filetype=cucumber expandtab shiftwidth=4 tabstop=4 softtabstop=4

" template language support (SGML / XML too)
" ------------------------------------------
" and disable that stupid html rendering (like making stuff bold etc)

fun! s:SelectHTML()
  let n = 1
  while n < 50 && n < line("$")
    " check for django
    if getline(n) =~ '{%\s*\(extends\|load\|block\|if\|for\|include\|trans\)\>'
      set ft=htmldjango
      return
    endif
    let n = n + 1
  endwhile
  " go with html
  set ft=html
endfun

autocmd FileType html,xhtml,xml,htmldjango,htmljinja,eruby,mako setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd BufNewFile,BufRead *.rhtml setlocal ft=eruby
autocmd BufNewFile,BufRead *.mako setlocal ft=mako
autocmd BufNewFile,BufRead *.tmpl setlocal ft=htmljinja
autocmd BufNewFile,BufRead *.py_tmpl setlocal ft=python
autocmd BufNewFile,BufRead *.html,*.htm  call s:SelectHTML()
let html_no_rendering=1

let g:closetag_default_xml=1
autocmd FileType html,htmldjango,htmljinja,eruby,mako let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,htmldjango,htmljinja,eruby,mako source ~/.vim/scripts/closetag.vim

" CSS
" ---
autocmd FileType css setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4

" Java
" ----
autocmd FileType java setlocal shiftwidth=2 tabstop=8 softtabstop=2 expandtab

" rst
" ---
autocmd BufNewFile,BufRead *.txt,*.md,*.rst setlocal ft=rst
autocmd FileType rst setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
\ formatoptions+=nqt textwidth=74

" C#
autocmd FileType cs setlocal tabstop=4 softtabstop=4 shiftwidth=4

" .sh
autocmd FileType sh setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab

" C/C++
autocmd FileType c setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType cpp setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType go setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab

" vim
" ---
autocmd FileType vim setlocal expandtab shiftwidth=2 tabstop=8 softtabstop=2

" Javascript
" ----------
autocmd FileType javascript setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4

" JSON
" ---------
au BufNewFile,BufRead *.json set filetype=json expandtab shiftwidth=2 softtabstop=2 tabstop=8 autoindent formatoptions=tcq2l textwidth=78

" Markdown
" --------
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Scala
" ----------
fun! s:DetectScala()
    if getline(1) == '#!/usr/bin/env scala'
        set filetype=scala
    endif
endfun

au BufRead,BufNewFile *.scala,*.sbt set filetype=scala
au BufRead,BufNewFile * call s:DetectScala()


" Less CSS
" ----------
syntax on
au BufNewFile,BufRead *.less set filetype=less expandtab shiftwidth=4 tabstop=4 softtabstop=4

set tags+=$HOME/.vim/tags/python.ctags
set tags+=$HOME/.vim/tags/django.ctags

autocmd FileType python set omnifunc=pythoncomplete#Complete
inoremap <Nul> <C-x><C-o>

" XPTemplate
" ----------
let g:scala_use_default_keymappings = 0
set hlsearch

" GOLANG
let g:go_fmt_command = "goimports"
au BufRead,BufNewFile *.go set filetype=go 
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

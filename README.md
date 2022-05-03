# dotfiles

Revisions of some ideas I've come across for basic sensible defaults for dotfiles

## vim

I've listed some requirements I want for a usable/sensible vim editor:

- Sensible Scrolling: [sidescroll=1](https://ddrscott.github.io/blog/2016/sidescroll/)
- Tree explorer: [NERD Tree](https://github.com/scrooloose/nerdtree)
- Fuzzy search: [Fzf + Ripgrep](https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2)
- Multiple Cursors: [vim-multiple-cursors](https://github.com/terryma/vim-multiple-cursors)
- Buffer navigation
- Comment things out: [vim-commentary](https://github.com/tpope/vim-commentary)
- syntax highlighting
- language support for: go, javascript, python, c++, c, html, css, markdown, scss
- handle braces/brackets/parens,quotes [auto-pairs](https://github.com/jiangmiao/auto-pairs)
- status/tabline: [vim-airline](https://github.com/vim-airline/vim-airline)
- git diff while editing file in gutter: [vim-gitgutter](https://github.com/airblade/vim-gitgutter)
- zen mode: [vim-zenroom2](https://github.com/amix/vim-zenroom2)
- indent lines: [indentLine](https://github.com/Yggdroot/indentLine)
- parameter completion for javascript: [jspc](https://github.com/othree/jspc.vim)
- json schema validation: [vison](https://github.com/Quramy/vison)
- debugging code with lldb: [viminspector](https://github.com/puremourning/vimspector)
- coc for code completion via language servers [coc.vim](https://github.com/neoclide/coc.nvim)
- navigate seamlessly with tmux: [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)
- auto format rust with `let g:rustfmt_autosave = 1`
- remap paste/cut/move to sane defaults
- setup keybindings for everything!

## tmux

For tmux I want to be able to navigate seamlessly between my workflow in vim as well.

- bind keys to quickly switch panes
- navigate between tmux and vim with hjkl [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)
- fix mouse mode in tmux for resizing panes and scrolling [tmux-better-mouse-mode](https://github.com/nhdaly/tmux-better-mouse-mode)
- fix yank to copy to clipboard (clipboard properly between tmux/vim and everywhere else) [tmux-yank](https://github.com/tmux-plugins/tmux-yank)
- send command keys to vim when navigating between panes (if vim) via bind-keys

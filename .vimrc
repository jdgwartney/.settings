filetype plugin indent on
syntax on

set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
set hlsearch
set incsearch

:filetype on
:autocmd FileType c,cpp :set cindent

:autocmd BufNewFile,BufRead *.json set ft=javascript

:ab #i if



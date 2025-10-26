let g:mapleader = " "
let g:maplocalleader = " "
set rnu nu lbr spr sb udf et nohls ic scs bri
if (has("termguicolors"))
  set termguicolors
endif
set path+=**
set tabstop=4 softtabstop=4 shiftwidth=4
set scrolloff=5
set formatoptions-=t
filetype plugin indent on
syntax on

let fortran_free_source=1
let fortran_more_precise=1
let fortran_do_enddo=1

"maps
nnoremap <leader>y "+y
nnoremap <leader>sf :find *
nnoremap <leader>sh :vert help 
inoremap jk <esc>
xnoremap <leader>s !sort<cr>
xnoremap <leader>S !sort --reverse<cr>

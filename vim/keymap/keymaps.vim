"" Saner behavior of n and N
" n to always search forward and N backward
" (https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n)
nnoremap <expr> n  'Nn'[v:searchforward]
xnoremap <expr> n  'Nn'[v:searchforward]
onoremap <expr> n  'Nn'[v:searchforward]

nnoremap <expr> N  'nN'[v:searchforward]
xnoremap <expr> N  'nN'[v:searchforward]
onoremap <expr> N  'nN'[v:searchforward]

"" Saner command-line history
" (https://github.com/mhinz/vim-galore#saner-command-line-history)
cnoremap <expr> <c-n> wildmenumode() ? "\<c-n>" : "\<down>"
cnoremap <expr> <c-p> wildmenumode() ? "\<c-p>" : "\<up>"

"" Saner CTRL-L
" (https://github.com/mhinz/vim-galore#saner-ctrl-l)
nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

"" Quickly move current line
" (https://github.com/mhinz/vim-galore#quickly-move-current-line)
" Sometimes I need a quick way to move the current line above or below
nnoremap [e  :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap ]e  :<c-u>execute 'move +'. v:count1<cr>

"" Don't lose selection when shifting sidewards
" (https://github.com/mhinz/vim-galore#dont-lose-selection-when-shifting-sidewards)
xnoremap <  <gv
xnoremap >  >gv

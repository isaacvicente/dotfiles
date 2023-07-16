" Set the catppuccin_mocha color scheme provided by https://github.com/catppuccin/vim#lightline
if isdirectory("$HOME/.vim/plugged/catppuccin") && isdirectory("$HOME/.vim/plugged/lightline.vim") 
    let g:lightline = {'colorscheme': 'catppuccin_mocha'} 
endif

if &runtimepath =~ 'catppuccin'
    echo 'ain ze da manga'
endif

" Or... set the gruvbox_material theme provided by https://github.com/sainnhe/gruvbox-material/blob/master/doc/gruvbox-material.txt
" if isdirectory("$HOME/.vim/plugged/gruvbox-material") && isdirectory("$HOME/.vim/plugged/lightline.vim") 
"     let g:lightline = {'colorscheme': 'gruvbox_material'}
" endif

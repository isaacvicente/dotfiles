" Set the catppuccin_mocha color scheme provided by https://github.com/catppuccin/vim#lightline
if &runtimepath =~ 'catppuccin' && &runtimepath =~ 'lightline.vim'
    let g:lightline = {'colorscheme': 'catppuccin_mocha'} 
endif

" Or... set the gruvbox_material theme provided by https://github.com/sainnhe/gruvbox-material/blob/master/doc/gruvbox-material.txt
" if &runtimepath =~ 'gruvbox-material' && &runtimepath =~ 'lightline.vim'
"     let g:lightline = {'colorscheme': 'gruvbox-material'} 
" endif

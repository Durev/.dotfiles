" Color scheme
if (has('termguicolors'))
    set termguicolors
endif

let g:material_terminal_italics = 1
let g:material_theme_style = 'default'

colorscheme material

" cursor line highlight
highlight CursorLine guibg=#34434a
highlight CursorLineNr guifg=#BDC3C7

" visual mode selection colour
highlight Visual guifg=none guibg=#0C4A6E gui=none

" gitsigns colors
highlight GitSignsDelete guifg=#E74C3C
highlight GitSignsChange guifg=#FACC15
highlight GitSignsAdd guifg=#2ECC71
highlight clear SignColumn

" slightly darker color for indent line (cf. help)
highlight IndentBlanklineChar guifg=#3d4e57 gui=nocombine

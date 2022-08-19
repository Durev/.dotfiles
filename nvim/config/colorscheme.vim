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

" indent blank lines (cf. help indent-blankline)
highlight IndentBlanklineChar guifg=#3d4e57 gui=nocombine
highlight IndentBlanklineContextChar guifg=#BDC3C7 gui=nocombine

" Cmp
" list of item kinds: https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/types/lsp.lua
" gray
highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
" lightgray
highlight! CmpItemAbbr guibg=NONE guifg=#DDDDDD
" blue
highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
" light blue
highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
highlight! CmpItemKindKeyword guibg=NONE guifg=#9CDCFE
" pink
highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
" lightgray
highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
" orange
highlight! CmpItemKindClass guibg=NONE guifg=#ffb62c
highlight! CmpItemKindModule guibg=NONE guifg=#ffb62c

" dashboard
highlight DashboardHeader guifg=#f8cf74
highlight DashboardCenter guifg=#c8e793
" DashboardShortCut DashboardFooter

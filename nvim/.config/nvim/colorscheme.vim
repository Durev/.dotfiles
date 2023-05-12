" Color scheme
if (has('termguicolors'))
    set termguicolors
endif

let g:material_terminal_italics = 1
let g:material_theme_style = 'default'

colorscheme material

" default background
highlight Normal guibg=#1e272e

" windows separator
highlight VertSplit guifg=#374855

" The JSON standard does not support comments (by design)
" So the default highlight is a bit aggressive for my poor eyes
highlight jsonCommentError guibg=#734720

highlight LineNr guifg=#475b67

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

" git diff and conflicts
highlight DiffAdd guibg=#405954
highlight DiffText guibg=#3c5a6e
highlight DiffDelete guibg=#694e37
highlight DiffChange guibg=#695e35

" indent blank lines (cf. help indent-blankline)
highlight IndentBlanklineChar guifg=#3d4e57 gui=nocombine
highlight IndentBlanklineContextChar guifg=#f1c40f gui=nocombine

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
highlight DashboardFooter guifg=#bdc3c7
" highlight DashboardShortCut

" vim-illuminate
highlight IlluminatedWordText guibg=#405159 gui=nocombine
highlight IlluminatedWordRead guibg=#405159 gui=nocombine
highlight IlluminatedWordWrite guibg=#405159 gui=nocombine

" Telescope
highlight TelescopePromptNormal guibg=#333A40
highlight TelescopePromptBorder guibg=#333A40 guifg=#E67E80
highlight TelescopePromptTitle guibg=#E67E80 guifg=#333A40
highlight TelescopeResultsNormal guibg=#232b31
highlight TelescopeResultsBorder guibg=#232b31 guifg=#232b31
highlight TelescopePreviewNormal guibg=#252d33
highlight TelescopePreviewBorder guibg=#252d33 guifg=#252d33
highlight TelescopePreviewTitle guibg=#83C092
highlight TelescopeSelection guibg=#333A40

" Treesitter context
highlight TreesitterContext guibg=#073148
highlight TreesitterContextLineNumber guifg=#3498db
" hi TreesitterContextBottom gui=underline guisp=Grey

" NvimTree
highlight NvimTreeNormal guibg=#192127

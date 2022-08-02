require('plugins')
require('keymaps')

vim.g['&t_8f'] = "\\<Esc>[38;2;%lu;%lu;%lum"
vim.g['&t_8b'] = "\\<Esc>[48;2;%lu;%lu;%lum"
vim.g.maplocalleader = " "
vim.g.mapleader = " "

vim.opt.tabstop=4
vim.opt.autoindent=true
vim.opt.cindent=true
vim.opt.expandtab=true
vim.opt.softtabstop=4
vim.opt.shiftwidth=4
vim.opt.smarttab=true
vim.opt.cursorline=true
vim.opt.showcmd =true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.wildmenu = true
vim.opt.clipboard=unnamed
vim.cmd('set clipboard+=unnamedplus')
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hidden = true

vim.opt.foldmethod = "indent"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

--vim.cmd [[
--hi SpellBad ctermbg=NONE ctermfg=14
--hi Normal guibg=NONE ctermbg=NONE
--hi SpellLocal ctermbg=NONE ctermfg=9
--hi Comment cterm=italic
--hi LineNr guibg=NONE ctermbg=NONE
--hi CursorLineNr cterm=bold ctermbg=11 ctermfg=15
--hi CursorLine cterm=bold ctermbg=0
--hi StatusLine ctermbg=0 ctermfg=15
--hi SpellLocal cterm=underline ctermfg=yellow
--]]




 ---------------- vimtex stuff ------------------------ 
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"
vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_indent_enabled = 0



vim.api.nvim_create_autocmd('TextYankPost', {
    group = num_au,
    callback = function()
        vim.highlight.on_yank({ higroup = 'Visual', timeout = 120 })
    end,
})

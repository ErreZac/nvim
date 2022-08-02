require('plugins')
require('keymaps')
require('settings')

-- stuff i don't remember what is for
vim.g['&t_8f'] = "\\<Esc>[38;2;%lu;%lu;%lum"
vim.g['&t_8b'] = "\\<Esc>[48;2;%lu;%lu;%lum"

-- treesitter folding
vim.opt.foldmethod = "indent"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- vimtex stuff ------------------------ 
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"
vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_indent_enabled = 0
vim.g.vimtex_syntax_enabled = 0

vim.api.nvim_create_autocmd('TextYankPost', {
    group = num_au,
    callback = function()
        vim.highlight.on_yank({ higroup = 'Visual', timeout = 120 })
    end,
})

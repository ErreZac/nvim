require('plugins')

vim.cmd [[
filetype plugin indent on 
syntax enable
colorscheme base16-default-dark
]]

vim.g['&t_8f'] = "\\<Esc>[38;2;%lu;%lu;%lum"
vim.g['&t_8b'] = "\\<Esc>[48;2;%lu;%lu;%lum"

vim.cmd [[
hi SpellBad ctermbg=NONE ctermfg=14
hi Normal guibg=NONE ctermbg=NONE
hi SpellLocal ctermbg=NONE ctermfg=9
hi Comment cterm=italic
hi LineNr guibg=NONE ctermbg=NONE
hi CursorLineNr cterm=bold ctermbg=11 ctermfg=15
hi CursorLine cterm=bold ctermbg=0
hi StatusLine ctermbg=0 ctermfg=15
hi SpellLocal cterm=underline ctermfg=yellow
]]

vim.opt.foldmethod = "indent"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"


-- Load custom tree-sitter grammar for org filetype


 ---------------- vimtex stuff ------------------------ 
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"
vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_indent_enabled = 0


--------------- deoplete and snippet --------------------
--vim.g['deoplete#enable_at_startup'] = 1

---------------- map leader -------------------------
vim.g.maplocalleader = " "
vim.g.mapleader = " "



--vim.api.nvim_set_keymap('i', '<C-k>', '<Plug>(neosnippet_expand_or_jump)', {silent = true})
--vim.api.nvim_set_keymap('s', '<C-k>', '<Plug>(neosnippet_expand_or_jump)', {silent = true})
--vim.api.nvim_set_keymap('x', '<C-k>', '<Plug>(neosnippet_expand_target)', {silent = true})
vim.api.nvim_set_keymap('n', '<C-u>', ':UndotreeToggle<CR>', {noremap = true})

vim.api.nvim_set_keymap('n', '<C-s>', ':setlocal spell! spelllang=en_us<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-t>', ':NvimTreeToggle<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', 'gV', '`[v`]', {noremap = true})
vim.api.nvim_set_keymap('n', '<esc>', ':noh<return><esc>', {noremap = true})

--vim.api.nvim_set_keymap(, {silent = true})

vim.api.nvim_set_keymap('n', '<C-p>', '<Plug>MarkdownPreviewToggle' , {silent = true})

vim.api.nvim_set_keymap('i', '<Up>', '<NOP>', {noremap = true})
vim.api.nvim_set_keymap('i', '<Down>', '<NOP>', {noremap = true})
vim.api.nvim_set_keymap('i', '<Left>', '<NOP>', {noremap = true})
vim.api.nvim_set_keymap('i', '<Right>', '<NOP>', {noremap = true})

vim.api.nvim_set_keymap('n', '<Up>', '<NOP>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Down>', '<NOP>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Left>', '<NOP>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Right>', '<NOP>', {noremap = true})

vim.api.nvim_set_keymap('v', '<Up>', '<NOP>', {noremap = true})
vim.api.nvim_set_keymap('v', '<Down>', '<NOP>', {noremap = true})
vim.api.nvim_set_keymap('v', '<Left>', '<NOP>', {noremap = true})
vim.api.nvim_set_keymap('v', '<Right>', '<NOP>', {noremap = true})

vim.api.nvim_set_keymap('n', '<C-z>', ':ZenMode<CR>', {noremap = true})

vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', {noremap = true})

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

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

vim.api.nvim_create_autocmd('TextYankPost', {
    group = num_au,
    callback = function()
        vim.highlight.on_yank({ higroup = 'Visual', timeout = 120 })
    end,
})

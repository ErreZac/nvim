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

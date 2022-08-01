require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'tpope/vim-surround'
    use 'preservim/nerdcommenter'
    use 'lervag/vimtex'
    use 'vim-scripts/c.vim'
    use 'mbbill/undotree'
 
    use ({ 'folke/zen-mode.nvim',
        config = function()
            require("zen-mode").setup {
                window = {
                width = .65 -- width will be 85% of the editor width
            }
        }
        end,
    })
 
    use 'chriskempson/base16-vim'
    --use 'Shougo/deoplete.nvim'
    --use 'Shougo/neonippet.vim'
    --use 'Shougo/neosnippet-snippets'
    use 'iamcco/markdown-preview.nvim'
 
    use ({ 'nvim-treesitter/nvim-treesitter',
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = {"lua", "c", "bash", "latex", "cpp"}, 
                highlight = { 
                    enable = true,
                },
                indent = {
                    enable = true,
                }
            }
        end,
    })
 
    use 'kyazdani42/nvim-web-devicons'
 
    use ({ 'kyazdani42/nvim-tree.lua',
        config = function()
            require("nvim-tree").setup()
        end,
    })
 
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'

    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use ({'hrsh7th/nvim-cmp',
        config = function()
            local cmp = require'cmp'

            cmp.setup({
              snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                   require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
              },
              window = {
                completion = cmp.config.window.bordered(),
                -- documentation = cmp.config.window.bordered(),
              },
              mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
              }),
              sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
              }, {
                { name = 'buffer' },
              })
            })

            -- Set configuration for specific filetype.
            cmp.setup.filetype('gitcommit', {
              sources = cmp.config.sources({
                { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
              }, {
                { name = 'buffer' },
              })
            })

            -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline('/', {
              mapping = cmp.mapping.preset.cmdline(),
              sources = {
                { name = 'buffer' }
              }
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
              mapping = cmp.mapping.preset.cmdline(),
              sources = cmp.config.sources({
                { name = 'path' }
              }, {
                { name = 'cmdline' }
              })
            })

            -- Setup lspconfig.
            local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
            require('lspconfig')['clangd'].setup {
              capabilities = capabilities
            }

            require('lspconfig')['texlab'].setup {
              capabilities = capabilities
            }
        end
    })

    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'

    use ({ 'nvim-neorg/neorg',
        config = function()
            require('neorg').setup {
                load = {
                    ["core.defaults"] = {}
                }
        }
        end,
    })
end)


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

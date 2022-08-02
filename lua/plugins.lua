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

    use ({'Everblush/everblush.nvim', 
        as = 'everblush',
        config = function()
            require('everblush').setup({ nvim_tree = { contrast = true } })
        end
    })

    use ({'RRethy/nvim-base16',
        config = function()
            --vim.cmd('colorscheme base16-ayu-dark')
        end
    })
 
    --use 'chriskempson/base16-vim'
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
            vim.opt.foldmethod = "indent"
            vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
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

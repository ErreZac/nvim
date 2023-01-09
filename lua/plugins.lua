require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'tpope/vim-surround'
    use 'christoomey/vim-tmux-navigator'

    use ({'lervag/vimtex',
        config = function()
            vim.g.vimtex_view_method = "zathura"
            vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"
            vim.g.vimtex_compiler_method = "latexmk"
            vim.g.vimtex_indent_enabled = 0
            vim.g.vimtex_syntax_enabled = 0
        end
    })

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

    use ({'catppuccin/nvim', 
        as = "catppuccin",
        config = function()
            vim.g.catppuccin_flavour = "mocha"
            require("catppuccin").setup({
                transparent_background = false,
                styles = {
                    comments = { "italic" },
                    conditionals = { "italic" },
                    loops = {},
                    functions = {"italic"},
                    keywords = {},
                    strings = {},
                    variables = {},
                    numbers = {},
                    booleans = {},
                    properties = {},
                    types = {},
                    operators = {},
                },
            })
            -- vim.cmd [[colorscheme catppuccin]]
        end
    })

    use ({'luisiacc/gruvbox-baby',
        config = function()
            vim.g.gruvbox_baby_background_color="dark"
            vim.g.gruvbox_baby_telescope_theme = 1
            vim.g.gruvbox_baby_transparent_mode = 1
            vim.g.gruvbox_baby_use_original_palette = 1
            vim.cmd[[colorscheme gruvbox-baby]]
        end,
    })

    use 'nvim-treesitter/nvim-treesitter-textobjects'     
    use ({ 'nvim-treesitter/nvim-treesitter',
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = {"lua", "c", "bash", "latex", "cpp", "rust"}, 
                highlight = { enable = true },
                indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<c-space>',
                        node_incremental = '<c-space>',
                        -- TODO: I'm not sure for this one.
                        scope_incremental = '<c-s>',
                        node_decremental = '<c-backspace>',
                    },
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner',
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            [']m'] = '@function.outer',
                            [']]'] = '@class.outer',
                        },
                        goto_next_end = {
                            [']M'] = '@function.outer',
                            [']['] = '@class.outer',
                        },
                        goto_previous_start = {
                            ['[m'] = '@function.outer',
                            ['[['] = '@class.outer',
                        },
                        goto_previous_end = {
                            ['[M'] = '@function.outer',
                            ['[]'] = '@class.outer',
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ['<leader>a'] = '@parameter.inner',
                        },
                        swap_previous = {
                            ['<leader>A'] = '@parameter.inner',
                        },
                    },
                },
            }
            vim.opt.foldmethod = "indent"
            vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
        end,
    })

    use 'kyazdani42/nvim-web-devicons'

    use ({ 'nvim-tree/nvim-tree.lua',
        config = function()
            require("nvim-tree").setup({
                update_focused_file = {
                    enable = true,
                    update_cwd = true,
                    ignore_list = {},
                },
            })
        end,
    })

    use 'nvim-lua/plenary.nvim'
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use ({'nvim-telescope/telescope.nvim', 
        config = function()
            require('telescope').setup {
                extensions = {
                    fzf = {
                        fuzzy = true,                    -- false will only do exact matching
                        override_generic_sorter = true,  -- override the generic sorter
                        override_file_sorter = true,     -- override the file sorter
                        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    }
                }
            }
            require('telescope').load_extension('fzf')
        end
    })
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
                    { name = 'buffer' },
                    { name = 'path' },
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
            local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
            require('lspconfig')['clangd'].setup {
                capabilities = capabilities
            }

            require("lspconfig").pyright.setup{}

            require('lspconfig')['rust_analyzer'].setup {
                on_attach = on_attach,
                settings = {
                    ["rust-analyzer"] = {
                        assist = {
                            importMergeBehavior = "last",
                            importPrefix = "by_self",
                        },
                        diagnostics = {
                            disabled = { "unresolved-import" }
                        },
                        cargo = {
                            loadOutDirsFromCheck = true
                        },
                        procMacro = {
                            enable = true
                        },
                        checkOnSave = {
                            command = "clippy"
                        },
                    }
                }
            }

            require('lspconfig')['texlab'].setup {
                capabilities = capabilities,
                settings = {
                    latex = {
                        build = {
                            onSave = true;
                        }
                    }
                }
            }
        end
    })

    use ({'simrat39/rust-tools.nvim', 
        config = function()
            require("rust-tools").setup({
                tools = {
                    runnables = {
                        use_telescope = true,
                    },
                    inlay_hints = {
                        auto = true,
                        show_parameter_hints = false,
                        parameter_hints_prefix = "",
                        other_hints_prefix = "",
                    },
                },
            })
        end,
    })

    use ({'L3MON4D3/LuaSnip'})
    use 'saadparwaiz1/cmp_luasnip'

    use ({ "iurimateus/luasnip-latex-snippets.nvim",
        -- requires = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
        config = function()
            require'luasnip-latex-snippets'.setup({use_treesitter=true})
            -- or setup({ use_treesitter = true })
        end,
        ft = "tex",
    })

    use ({ 'nvim-neorg/neorg',
        config = function()
            require('neorg').setup {
                load = {
                    ["core.defaults"] = {}
                }
            }
        end,
    })

    use ({'norcalli/nvim-colorizer.lua', 
        config = function()
            require'colorizer'.setup()
        end
    })

    use 'ggandor/lightspeed.nvim'

    use ({'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    })

    use ({'lukas-reineke/indent-blankline.nvim',
        config = function() 
            vim.opt.list = true
            vim.opt.listchars:append "eol:↴"
            require('indent_blankline').setup {
                char = '┊',
                show_trailing_blankline_indent = true,
                show_current_context = true,
                show_current_context_start = true,
                show_end_of_line = true,
            }
        end
    })

    use ({'nvim-lualine/lualine.nvim',
        config = function()
            local colors = {
                red = '#fb4934',
                lgrey = '#665c54',
                grey = '#3c3836', --
                yellow = '#d79921', --282828 
                black = '#282828 ',
                white = '#fbf1c7',
                light_green = '#8ec07c',
                blue = '#83a598',
                green = '#b8bb26',
            }

            local theme = {
                normal = {
                    a = { fg = colors.black, bg = colors.yellow },
                    b = { fg = colors.white, bg = colors.grey },
                    c = { fg = colors.white, bg = colors.lgrey },
                    z = { fg = colors.white, bg = colors.black },
                },
                insert = { a = { fg = colors.black, bg = colors.light_green } },
                visual = { a = { fg = colors.black, bg = colors.blue } },
                replace = { a = { fg = colors.black, bg = colors.green } },
            }

            local empty = require('lualine.component'):extend()
            function empty:draw(default_highlight)
                self.status = ''
                self.applied_separator = ''
                self:apply_highlights(default_highlight)
                self:apply_section_separators()
                return self.status
            end

            -- Put proper separators and gaps between components in sections
            local function process_sections(sections)
                for name, section in pairs(sections) do
                    local left = name:sub(9, 10) < 'x'
                    for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
                        table.insert(section, pos * 2, { empty, color = { fg = colors.lgrey, bg = colors.lgrey } })
                    end
                    for id, comp in ipairs(section) do
                        if type(comp) ~= 'table' then
                            comp = { comp }
                            section[id] = comp
                        end
                        comp.separator = left and { right = '' } or { left = '' }
                    end
                end
                return sections
            end

            local function search_result()
                if vim.v.hlsearch == 0 then
                    return ''
                end
                local last_search = vim.fn.getreg('/')
                if not last_search or last_search == '' then
                    return ''
                end
                local searchcount = vim.fn.searchcount { maxcount = 9999 }
                return last_search .. '(' .. searchcount.current .. '/' .. searchcount.total .. ')'
            end

            local function modified()
                if vim.bo.modified then
                    return '+'
                elseif vim.bo.modifiable == false or vim.bo.readonly == true then
                    return '-'
                end
                return ''
            end

            require('lualine').setup {
                options = {
                    theme = theme,
                    component_separators = '',
                    section_separators = { left = '', right = '' },
                },
                sections = process_sections {
                    lualine_a = { 'mode' },
                    lualine_b = {
                        'branch',
                        'diff',
                        {
                            'diagnostics',
                            source = { 'nvim' },
                            sections = { 'error' },
                            diagnostics_color = { error = { bg = colors.red, fg = colors.lgrey } },
                        },
                        {
                            'diagnostics',
                            source = { 'nvim' },
                            sections = { 'warn' },
                            diagnostics_color = { warn = { bg = colors.orange, fg = colors.lgrey } },
                        },
                        { 'filename', file_status = false, path = 1 },
                        { modified, color = { bg = colors.red } },
                        {
                            '%w',
                            cond = function()
                                return vim.wo.previewwindow
                            end,
                        },
                        {
                            '%r',
                            cond = function()
                                return vim.bo.readonly
                            end,
                        },
                        {
                            '%q',
                            cond = function()
                                return vim.bo.buftype == 'quickfix'
                            end,
                        },
                    },
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = { search_result, 'filetype' },
                    lualine_z = { '%l:%c', '%p%%/%L' },
                },
                inactive_sections = {
                    lualine_c = { '%f %y %m' },
                    lualine_x = {},
                },
            }
        end
    })

end)

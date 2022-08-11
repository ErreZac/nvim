-- map leader key
vim.g.maplocalleader = " "
vim.g.mapleader = " "

-- tab stuff
vim.opt.tabstop=4
vim.opt.expandtab=true
vim.opt.softtabstop=4
vim.opt.shiftwidth=4
vim.opt.smarttab=true

--vim.opt.autoindent=true
--vim.opt.cindent=true

-- line and numbers
vim.opt.cursorline=true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showcmd =true

-- search stuff
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- clipboard stuff
vim.opt.clipboard=unnamed
vim.cmd('set clipboard+=unnamedplus')

-- boh
vim.opt.hidden = true
vim.opt.termguicolors = true
vim.opt.wildmenu = true


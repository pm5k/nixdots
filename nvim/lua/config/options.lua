-- Neovim Options Configuration
-- Global settings and vim options

-- Set <space> as the leader key
-- Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Mouse configuration
vim.opt.mouse = ''
vim.opt.mousescroll = 'ver:0,hor:0'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim
-- Schedule the setting after `UiEnter` because it can increase startup-time
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- File handling
vim.opt.undofile = true
vim.opt.swapfile = false

-- Search configuration
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = 'split' -- Preview substitutions live, as you type!

-- UI configuration
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.shortmess = 'I'
vim.opt.termguicolors = true
vim.opt.winborder = 'rounded'

-- Whitespace visualization
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Indentation configuration
vim.opt.breakindent = true
vim.opt.tabstop = 8
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
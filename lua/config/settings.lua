-- Enable loading plugins faster
vim.loader.enable()

-- Set leader keys to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Enable true color support
vim.o.termguicolors = true

-- Highlight search results
vim.o.hlsearch = true

-- Enable line numbers
vim.wo.number = true

-- Enable relative line numbers
vim.wo.relativenumber = true

-- Enable mouse support
vim.o.mouse = "a"

-- Enable break indent
vim.o.breakindent = true

-- Enable undo file
vim.o.undofile = true

-- Ignore case in search
vim.o.ignorecase = true

-- Enable smart case
vim.o.smartcase = true

-- Always show sign column
vim.wo.signcolumn = "yes"

-- Set update time for diagnostics
vim.o.updatetime = 250

-- Leader command timeout
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completion options
vim.o.completeopt = "menuone,noselect"

-- Enable smart indent
vim.opt.smartindent = true

-- Enable text wrapping
vim.opt.wrap = true

-- Disable swap file
vim.opt.swapfile = false

-- Disable backup file
vim.opt.backup = false

-- Set undo levels
vim.opt.undolevels = 30000

-- Set scroll offset
vim.opt.scrolloff = 15

-- Update time for CursorHold
vim.opt.updatetime = 50

-- Enable auto write
vim.opt.autowrite = true

-- Disable cursor line
vim.opt.cursorline = false

-- Enable confirm dialog when leaving buffer
vim.opt.confirm = true

-- Set spell check language
vim.opt.spelllang = "en"

-- Set fill characters after EOF
vim.opt.fillchars:append({ eob = " " })

-- Indentation
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- vim.g.clipboard = {
-- 	name = 'OSC 52',
-- 	copy = {
-- 		['+'] = require('vim.ui.clipboard.osc52').copy('+'),
-- 		['*'] = require('vim.ui.clipboard.osc52').copy('*'),
-- 	},
-- 	paste = {
-- 		['+'] = require('vim.ui.clipboard.osc52').paste('+'),
-- 		['*'] = require('vim.ui.clipboard.osc52').paste('*'),
-- 	},
-- }

-- Floating hover window: K
-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
-- 	vim.lsp.handlers.hover, {
-- 		border = "single",
-- 		-- title = "hover"
-- 	}
-- )

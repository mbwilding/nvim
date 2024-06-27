-- Enable loading plugins faster
vim.loader.enable()

-- Set leader keys to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Enable true color support
vim.o.termguicolors = true

-- Dark theme
vim.o.background = "dark"

-- Highlight search results
vim.o.hlsearch = true

-- Enable line numbers
vim.wo.number = true

-- Enable relative line numbers
vim.wo.relativenumber = true

-- Disable mouse support
vim.o.mouse = ""

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

-- Allow backspacing over everything
vim.o.backspace = "indent,eol,start"

-- Enable smart indent
vim.o.smartindent = true

-- Enable text wrapping
vim.o.wrap = true

-- Disable swap file
vim.o.swapfile = false

-- Disable backup file
vim.o.backup = false

-- Set undo levels
vim.o.undolevels = 30000

-- Set scroll offset
vim.o.scrolloff = 10

-- Update time for CursorHold
vim.o.updatetime = 50

-- Enable auto write
vim.o.autowrite = true

-- Disable cursor line
vim.o.cursorline = false

-- Enable confirm dialog when leaving buffer
vim.o.confirm = true

-- Set spell check language
vim.o.spelllang = "en"

-- Set fill characters after EOF
vim.opt.fillchars:append({ eob = " " })

-- Indentation
vim.o.shiftwidth = 4
vim.o.tabstop = 4

-- Splits
vim.o.splitright = true
vim.o.splitbelow = true

-- Single status line
vim.o.laststatus = 3

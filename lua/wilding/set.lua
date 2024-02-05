--vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.undofile = true
vim.opt.undolevels = 30000

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 12
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- vim.opt.colorcolumn = "140"

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Map ; to :
vim.api.nvim_set_keymap("n", ";", ":", { noremap = true, silent = true })

vim.opt.autowrite = true          -- Enable auto write
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.clipboard = "unnamedplus" -- Sync with system clipboard

vim.opt.confirm = true            -- Confirm to save changes before exiting modified buffer
vim.opt.cursorline = true         -- Enable highlighting of the current line


vim.opt.wildmode = "longest:full,full" -- Command-line completion mode
vim.opt.spelllang = { "en" }
vim.opt.showmode = false
vim.opt.shortmess:append({ W = true, I = true, c = true })
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
vim.opt.pumblend = 10          -- Popup blend
vim.opt.pumheight = 20         -- Maximum number of entries in a popup
vim.opt.inccommand = "nosplit" -- preview incremental substitute
vim.opt.laststatus = 0
vim.opt.list = true            -- Show some invisible characters (tabs...
vim.opt.listchars.trail = "·"
vim.opt.mouse = "a"                -- Enable mouse mode
vim.opt.number = true              -- Print line number
vim.opt.formatoptions = "jcroqlnt" -- tcqj
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"

vim.g.markdown_recommended_style = 0

vim.opt.formatoptions:remove { "c", "r", "o" }

-- Remap delete commands to use black-hole register
vim.api.nvim_set_keymap("n", "d", '"_d', { noremap = true })
vim.api.nvim_set_keymap("n", "dd", '"_dd', { noremap = true })
vim.api.nvim_set_keymap("n", "D", '"_D', { noremap = true })
vim.api.nvim_set_keymap("n", "x", '"_x', { noremap = true })
vim.api.nvim_set_keymap("n", "X", '"_X', { noremap = true })
vim.api.nvim_set_keymap("n", "s", '"_s', { noremap = true })
vim.api.nvim_set_keymap("x", "d", '"_d', { noremap = true })

vim.g.OmniSharp_server_use_net6 = 1

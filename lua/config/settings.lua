-- Enable loading plugins faster
vim.loader.enable()

-- Set leader key to space
vim.g.mapleader = " "

-- Nerd font
vim.g.have_nerd_font = true

-- Enable true color support
vim.o.termguicolors = true

-- Dark theme
vim.o.background = "dark"

-- Highlight search results
vim.o.hlsearch = true

-- Gutter line numbers
vim.wo.number = true

-- Gutter relative line numbers
vim.wo.relativenumber = false

-- Gutter sign column
vim.wo.signcolumn = "yes"

-- Mouse mode
vim.o.mouse = "a"
vim.o.mousemodel = ""

-- Enable break indent
vim.o.breakindent = true

-- Enable undo file
vim.o.undofile = true

-- Ignore case in search
vim.o.ignorecase = true

-- Enable smart case
vim.o.smartcase = true

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

-- Text wrapping
vim.o.wrap = false

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

-- Line break
vim.o.linebreak = true

-- Spell checking
vim.o.spelllang = "en_au"
-- vim.o.spell = true

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

-- TODO: MOVE
-- Icons
vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
vim.fn.sign_define(
    "DapBreakpointCondition",
    { text = "ﳁ", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define(
    "DapBreakpointRejected",
    { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define(
    "DapLogPoint",
    { text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
)
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })
vim.fn.sign_define("DapBreakpoint", {
    text = "⦿",
    texthl = "DapBreakpoint",
    linehl = "DapBreakpoint",
    numhl = "DapBreakpoint",
})

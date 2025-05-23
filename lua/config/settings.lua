local g = vim.g
local o = vim.o
local opt = vim.opt
local wo = vim.wo

local leader = " "

g.have_nerd_font = true
g.mapleader = leader
g.maplocalleader = leader
o.autowrite = true
o.background = "dark"
o.backspace = "indent,eol,start"
o.backup = false
o.breakindent = true
o.completeopt = "menuone,noselect"
o.confirm = true
o.cursorline = false
o.hlsearch = true
o.ignorecase = true
o.inccommand = "split"
o.laststatus = 3
o.linebreak = true
o.list = true
o.mouse = "a"
o.mousemodel = "extend"
o.scrolloff = 3
o.shiftwidth = 4
o.showmode = false
o.smartcase = true
o.smartindent = true
o.spell = true
o.spelllang = "en_au"
o.splitbelow = true
o.splitright = true
o.swapfile = false
o.tabstop = 4
o.termguicolors = true
o.timeout = true
o.timeoutlen = 300
o.undofile = true
o.undolevels = 30000
o.updatetime = 250
o.updatetime = 50
o.wrap = false
opt.fillchars:append({ eob = " " })
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
wo.number = true
wo.relativenumber = false
wo.signcolumn = "auto:2"

-- Virtual Text
vim.diagnostic.config({
    virtual_lines = {
        current_line = true,
    },
})

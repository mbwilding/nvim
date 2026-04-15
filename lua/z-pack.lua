vim.pack.add({ "https://github.com/zuqini/zpack.nvim" }, { confirm = false })

require("zpack").setup({
    { import = "plugins" },
    defaults = {
        confirm = false,
        cond = nil,
    },
    performance = {
        vim_loader = true,
    },
    cmd_prefix = 'Z',
})

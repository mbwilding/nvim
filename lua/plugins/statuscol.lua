return {
    "https://github.com/luukvbaal/statuscol.nvim",
    lazy = false,
    config = function()
        local builtin = require("statuscol.builtin")
        require("statuscol").setup({
            relculright = true,
            segments = {
                { text = { "%s" } },
                { text = { builtin.lnumfunc } },
                {
                    text = { " ", builtin.foldfunc, " " },
                    condition = { builtin.not_empty, true, builtin.not_empty },
                },
            },
        })
    end,
}

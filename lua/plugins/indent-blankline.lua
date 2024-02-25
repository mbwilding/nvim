return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
        local ibl = require("ibl")
        local isEnabled = false

        ibl.setup({
            enabled = isEnabled
        })

        vim.keymap.set("n", "<leader>ib", function()
            isEnabled = not isEnabled
            ibl.setup({
                enabled = isEnabled
            })
        end, { desc = "Indent Blankline: Toggle" })
    end
}

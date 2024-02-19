return {
    "mbwilding/centerpad.nvim",
    config = function()
        vim.keymap.set(
            "n",
            "<leader>z",
            "<cmd>lua require'centerpad'.toggle{ leftpad = 30, rightpad = 30 }<cr>",
            {silent = true, noremap = true}
        )
    end
}

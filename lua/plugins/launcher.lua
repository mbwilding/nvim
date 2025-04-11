return {
    "mbwilding/launcher.nvim",
    dev = true,
    config = function()
        local utils = require("launcher.utils")

        vim.keymap.set("n", "<leader>0", function()
            local files = utils.get_relevant_files()

            for _, file in ipairs(files) do
                print(file)
            end
        end, { desc = "Launcher" })
    end,
}

-- AI like Cursor

vim.pack.add({
    "http://github.com/yetone/avante.nvim",
    "http://github.com/nvim-lua/plenary.nvim",
    "http://github.com/MunifTanjim/nui.nvim",
    "http://github.com/echasnovski/mini.pick",
    -- "http://github.com/nvim-telescope/telescope.nvim",
    -- "http://github.com/hrsh7th/nvim-cmp",
    -- "http://github.com/ibhagwan/fzf-lua",
    -- "http://github.com/stevearc/dressing.nvim",
    "http://github.com/folke/snacks.nvim",
    "http://github.com/nvim-tree/nvim-web-devicons",
    "http://github.com/zbirenbaum/copilot.lua",
    -- "http://github.com/Kaiser-Yang/blink-cmp-avante",
    "http://github.com/HakonHarnes/img-clip.nvim",
}, { confirm = false })

vim.keymap.set("n", "<leader><enter>", function()
    require("actions-preview").code_actions()
end, { desc = "Actions Preview" })

local plugin_path = vim.fn.stdpath("data") .. "/site/pack/core/opt/avante.nvim"
local build_cmd = vim.fn.has("win32") == 0 and "make"
    or "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
vim.fn.jobstart(build_cmd, { cwd = plugin_path, detatch = true })

---@type avante.Config
local opts = {
    hints = {
        enabled = false,
    },
    provider = "openai",
    providers = {
        openai = {
            model = "gpt-4.1-2025-04-14",
            timeout = 30000,
            extra_request_body = {
                temperature = 0.75,
                max_tokens = 20480,
            },
        },
    },
}

require("avante").setup(opts)

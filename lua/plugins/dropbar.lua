return {
    -- "Bekaboo/dropbar.nvim",
    "mbwilding/dropbar.nvim",
    -- dev = true,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            -- Build command adjusted to use 'make' if available, otherwise 'cmake'
            build = function()
                if vim.fn.executable("make") == 1 then
                    return "make"
                elseif vim.fn.executable("cmake") == 1 then
                    return
                    "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
                else
                    error("Neither 'make' nor 'cmake' are available for building telescope-fzf-native.nvim")
                end
            end,
            -- This plugin is conditionally loaded if either 'make' or 'cmake' is available
            cond = function()
                return vim.fn.executable("make") == 1 or vim.fn.executable("cmake") == 1
            end,
        },
    },
    opts = {
        sources = {
            path = {
                max_depth = 16,
            },
            treesitter = {
                max_depth = 0,
            },
            lsp = {
                max_depth = 0,
            },
            markdown = {
                max_depth = 0,
            },
            terminal = {
                show_current = false,
            },
        },
    },
}

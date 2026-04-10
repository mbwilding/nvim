return {
    "pmizio/typescript-tools.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "neovim/nvim-lspconfig",
    },
    opts = {
        settings = {
            tsserver_max_memory = 8192,
            tsserver_file_preferences = {
                includeCompletionsForModuleExports = true,
            },
            -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
            -- possible values: ("off"|"all"|"implementations_only"|"references_only")
            code_lens = "off",
            jsx_close_tag = {
                enable = false,
                filetypes = { "javascriptreact", "typescriptreact" },
            },
        },
    },
}

-- Dadbod is a plugin that provides a way for managing databases.

return {
    "kristijanhusak/vim-dadbod-ui",
    lazy = true,
    dependencies = {
        { "tpope/vim-dadbod", lazy = true },
        { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
        "DBUI",
        "DBUIToggle",
        "DBUIAddConnection",
        "DBUIFindBuffer",
    },
    keys = {
        {
            "<leader>dbb",
            "<CMD>DBUI<CR>",
            desc = "Dadbod: UI",
        },
        {
            "<leader>dbt",
            "<CMD>DBUIToggle<CR>",
            desc = "Dadbod: Toggle",
        },
    },
    config = function()
        vim.g.db_ui_use_nerd_fonts = 1

        require("cmp").setup.filetype({ "sql" }, {
            sources = {
                { name = "vim-dadbod-completion" },
                { name = "buffer" },
            },
        })

        vim.g.dbs = {
            { name = "pg-docker", url = "postgres://postgres:Developer01@localhost:5432/_Namespace._CapabilityName" },
        }
    end,
}

-- Dadbod is a plugin that provides a way for managing databases.

return {
    "tpope/vim-dadbod",
    lazy = true,
    dependencies = {
        { "kristijanhusak/vim-dadbod-ui", lazy = true },
        -- {
        --     "kristijanhusak/vim-dadbod-completion",
        --     lazy = true,
        --     ft =
        --     {
        --         "sql",
        --         "mysql",
        --         "plsql"
        --     },
        -- },
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

        -- require("cmp").setup.filetype({ "sql" }, {
        --     sources = {
        --         { name = "vim-dadbod-completion" },
        --         { name = "buffer" },
        --     },
        -- })

        vim.g.dbs = {
            { name = "pg-docker-capabilityhub", url = "postgres://postgres:Developer01@localhost:5432/CapabilityHub" },
            { name = "pg-docker", url = "postgres://postgres:Developer01@localhost:5432" },
            { name = "pg-truenas", url = "postgres://postgres:Developer01@truenas:5432/_CapabilityName" },
        }
    end,
}

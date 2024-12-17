-- Crates is a plugin that provides information about Rust crates in your Cargo.toml file.

return {
    "saecki/crates.nvim",
    lazy = true,
    event = { "BufRead Cargo.toml" },
    keys = {
        {
            "<leader>Rt",
            function()
                require("lua.plugins.crates").toggle()
            end,
            desc = "Crates: Toggle",
        },
        {
            "<leader>Rr",
            function()
                require("lua.plugins.crates").reload()
            end,
            desc = "Crates: Reload",
        },
        {
            "<leader>Rv",
            function()
                require("lua.plugins.crates").show_versions_popup()
            end,
            desc = "Crates: Versions popup",
        },
        {
            "<leader>Rf",
            function()
                require("lua.plugins.crates").show_features_popup()
            end,
            desc = "Crates: Features popup",
        },
        {
            "<leader>Rd",
            function()
                require("lua.plugins.crates").show_dependencies_popup()
            end,
            desc = "Crates: Dependencies Popup",
        },
        {
            "<leader>Ru",
            function()
                require("lua.plugins.crates").update_crate()
            end,
            desc = "Crates: Update",
        },
        {
            "<leader>Ru",
            function()
                require("lua.plugins.crates").update_crates()
            end,
            desc = "Crates: Update selected",
            mode = "v",
        },
        {
            "<leader>Ra",
            function()
                require("lua.plugins.crates").update_all_crates()
            end,
            desc = "Crates: Update all",
        },
        {
            "<leader>RU",
            function()
                require("lua.plugins.crates").upgrade_crate()
            end,
            desc = "Crates: Upgrade",
        },
        {
            "<leader>RU",
            function()
                require("lua.plugins.crates").upgrade_crates()
            end,
            desc = "Crates: Upgrade selected",
            mode = "v",
        },
        {
            "<leader>RA",
            function()
                require("lua.plugins.crates").upgrade_all_crates()
            end,
            desc = "Crates: Upgrade all",
        },
        {
            "<leader>Rx",
            function()
                require("lua.plugins.crates").expand_plain_crate_to_inline_table()
            end,
            desc = "Crates: Expand to table",
        },
        {
            "<leader>RX",
            function()
                require("lua.plugins.crates").extract_crate_into_table()
            end,
            desc = "Crates: Extract into table",
        },
    },
    opts = {},
}

return {
    'saecki/crates.nvim',
    --tag = "stable",
    event = { "BufRead Cargo.toml" },
    config = function()
        local crates = require("crates")
        crates.setup()

        vim.keymap.set("n", "<leader>ct", crates.toggle, { silent = true, desc = "Crates: Toggle" })
        vim.keymap.set("n", "<leader>cr", crates.reload, { silent = true, desc = "Crates: Reload" })

        vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, { silent = true, desc = "Crates: Versions popup" })
        vim.keymap.set("n", "<leader>cf", crates.show_features_popup, { silent = true, desc = "Crates: Features popup" })
        vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup,
            { silent = true, desc = "Crates: Dependencies Popup" })

        vim.keymap.set("n", "<leader>cu", crates.update_crate, { silent = true, desc = "Crates: Update" })
        vim.keymap.set("v", "<leader>cu", crates.update_crates, { silent = true, desc = "Crates: Update selected" })
        vim.keymap.set("n", "<leader>ca", crates.update_all_crates, { silent = true, desc = "Crates: Update all" })
        vim.keymap.set("n", "<leader>cU", crates.upgrade_crate, { silent = true, desc = "Crates: Upgrade" })
        vim.keymap.set("v", "<leader>cU", crates.upgrade_crates, { silent = true, desc = "Crates: Upgrade selected" })
        vim.keymap.set("n", "<leader>cA", crates.upgrade_all_crates, { silent = true, desc = "Crates: Upgrade all" })

        vim.keymap.set("n", "<leader>cx", crates.expand_plain_crate_to_inline_table,
            { silent = true, desc = "Crates: Expand to table" })
        vim.keymap.set("n", "<leader>cX", crates.extract_crate_into_table,
            { silent = true, desc = "Crates: Extract into table" })

        vim.keymap.set("n", "<leader>cH", crates.open_homepage, { silent = true, desc = "Crates: Homepage" })
        vim.keymap.set("n", "<leader>cR", crates.open_repository, { silent = true, desc = "Crates: Repository" })
        vim.keymap.set("n", "<leader>cD", crates.open_documentation, { silent = true, desc = "Crates: Documentation" })
        vim.keymap.set("n", "<leader>cC", crates.open_crates_io, { silent = true, desc = "Crates: IO" })
    end,
}

-- Crates is a plugin that provides information about Rust crates in your Cargo.toml file.
-- TODO: event = { "BufRead Cargo.toml" },

vim.pack.add({
    "https://github.com/saecki/crates.nvim",
}, { confirm = false })

vim.keymap.set("n", "<leader>Rt", function()
    require("lua.plugins.crates").toggle()
end, { desc = "Crates: Toggle" })

vim.keymap.set("n", "<leader>Rr", function()
    require("lua.plugins.crates").reload()
end, { desc = "Crates: Reload" })

vim.keymap.set("n", "<leader>Rv", function()
    require("lua.plugins.crates").show_versions_popup()
end, { desc = "Crates: Version Popup" })

vim.keymap.set("n", "<leader>Rf", function()
    require("lua.plugins.crates").show_features_popup()
end, { desc = "Crates: Features Popup" })

vim.keymap.set("n", "<leader>Rd", function()
    require("lua.plugins.crates").show_dependencies_popup()
end, { desc = "Crates: Dependencies Popup" })

vim.keymap.set("n", "<leader>Ru", function()
    require("lua.plugins.crates").update_crate()
end, { desc = "Crates: Update" })

vim.keymap.set("v", "<leader>Ru", function()
    require("lua.plugins.crates").update_crates()
end, { desc = "Crates: Update Selected" })

vim.keymap.set("n", "<leader>Ra", function()
    require("lua.plugins.crates").update_all_crates()
end, { desc = "Crates: Update All" })

vim.keymap.set("n", "<leader>RU", function()
    require("lua.plugins.crates").upgrade_crate()
end, { desc = "Crates: Upgrade" })

vim.keymap.set("v", "<leader>RU", function()
    require("lua.plugins.crates").upgrade_crate()
end, { desc = "Crates: Upgrade Selected" })

vim.keymap.set("n", "<leader>RA", function()
    require("lua.plugins.crates").upgrade_all_crates()
end, { desc = "Crates: Upgrade All" })

vim.keymap.set("n", "<leader>Rx", function()
    require("lua.plugins.crates").expand_plain_crate_to_inline_table()
end, { desc = "Crates: Expand To Table" })

vim.keymap.set("n", "<leader>RX", function()
    require("lua.plugins.crates").extract_crate_into_table()
end, { desc = "Crates: Extract Into Table" })

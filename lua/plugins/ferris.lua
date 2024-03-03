return {
    'vxpm/ferris.nvim',
    config = function()
        require("ferris").setup()

        vim.keymap.set("n", "<leader>re", require("ferris.methods.expand_macro"),
            { silent = true, desc = "Ferris: Expand macro" })
        vim.keymap.set("n", "<leader>rj", require("ferris.methods.join_lines"),
            { silent = true, desc = "Ferris: Join lines" })
        vim.keymap.set("n", "<leader>rH", require("ferris.methods.view_hir"), { silent = true, desc = "Ferris: HIR" })
        vim.keymap.set("n", "<leader>rM", require("ferris.methods.view_mir"), { silent = true, desc = "Ferris: MIR" })
        vim.keymap.set("n", "<leader>rl", require("ferris.methods.view_memory_layout"),
            { silent = true, desc = "Ferris: Memory layout" })
        vim.keymap.set("n", "<leader>ri", require("ferris.methods.view_item_tree"),
            { silent = true, desc = "Ferris: Item tree" })
        vim.keymap.set("n", "<leader>rs", require("ferris.methods.view_syntax_tree"),
            { silent = true, desc = "Ferris: Syntax tree" })
        vim.keymap.set("n", "<leader>rc", require("ferris.methods.open_cargo_toml"),
            { silent = true, desc = "Ferris: Open Cargo.toml" })
        vim.keymap.set("n", "<leader>rp", require("ferris.methods.open_parent_module"),
            { silent = true, desc = "Ferris: Open parent module" })
        vim.keymap.set("n", "<leader>rof", require("ferris.methods.open_documentation"),
            { silent = true, desc = "Ferris: Open documentation" })
        vim.keymap.set("n", "<leader>rw", require("ferris.methods.reload_workspace"),
            { silent = true, desc = "Ferris: Reload workspace" })
        vim.keymap.set("n", "<leader>rm", require("ferris.methods.rebuild_macros"),
            { silent = true, desc = "Ferris: Rebuild macros" })
    end
}

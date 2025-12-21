return {
    "stevearc/oil.nvim",
    lazy = false,
    dev = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "refractalize/oil-git-status.nvim",
        "JezerM/oil-lsp-diagnostics.nvim",
    },
    keys = {
        {
            "-",
            "<CMD>Oil<CR>",
            desc = "Oil: Open parent directory",
        },
    },
    opts = {
        keymaps = {
            ["g?"] = { "actions.show_help", mode = "n" },
            ["<CR>"] = "actions.select",
            ["<C-s>"] = { "actions.select", opts = { vertical = true } },
            ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
            ["<C-t>"] = { "actions.select", opts = { tab = true } },
            ["<C-p>"] = "actions.preview",
            ["q"] = { "actions.close", mode = "n" },
            ["<C-r>"] = "actions.refresh",
            ["-"] = { "actions.parent", mode = "n" },
            ["_"] = { "actions.open_cwd", mode = "n" },
            ["`"] = { "actions.cd", mode = "n" },
            ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
            ["gs"] = { "actions.change_sort", mode = "n" },
            ["gx"] = "actions.open_external",
            ["g."] = { "actions.toggle_hidden", mode = "n" },
            ["g\\"] = { "actions.toggle_trash", mode = "n" },
        },
        use_default_keymaps = false,
        default_file_explorer = true,
        columns = {
            -- "birthtime",
            -- "mtime",
            "ctime",
            -- "atime",
            -- "type",
            "size",
            "permissions",
            "icon",
        },
        lsp_file_methods = {
            autosave_changes = true,
        },
        delete_to_trash = false,
        skip_confirm_for_simple_edits = false,
        prompt_save_on_select_new_entry = true,
        cleanup_delay_ms = 2000,
        constrain_cursor = false,
        win_options = {
            wrap = false,
            signcolumn = "auto:2",
            cursorcolumn = false,
            foldcolumn = "0",
            spell = false,
            list = false,
            conceallevel = 3,
            concealcursor = "nvic",
        },
        view_options = {
            show_hidden = false,
            is_hidden_file = function(name, _)
                local contains_list = { ".Trash" }
                local equals_list = { ".DS_Store", ".directory" }

                for _, prefix in ipairs(contains_list) do
                    if vim.startswith(name, prefix) then
                        return true
                    end
                end

                for _, exact in ipairs(equals_list) do
                    if name == exact then
                        return true
                    end
                end

                return false
            end,
            is_always_hidden = function(name, _)
                return name == "." or name == ".."
            end,
            sort = {
                { "type", "asc" },
                { "name", "asc" },
            },
        },
    },
    config = function(_, opts)
        require("oil").setup(opts)

        require("oil-git-status").setup({
            show_ignored = true,
            symbols = {
                index = {
                    ["A"] = "+",
                    ["D"] = "-",
                    ["M"] = "~",
                },
                working_tree = {
                    ["A"] = "+",
                    ["D"] = "-",
                    ["M"] = "~",
                },
            },
        })

        require("oil-lsp-diagnostics").setup({
            count = true,
            parent_dirs = true,
            -- diagnostic_symbols = {
            --     error = "",
            --     warn = "",
            --     info = "",
            --     hint = "󰌶",
            -- },
        })
    end,
}

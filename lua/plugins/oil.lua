return {
    "stevearc/oil.nvim",
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
        -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
        -- Set to false if you still want to use netrw.
        default_file_explorer = true,
        -- Id is automatically added at the beginning, and name at the end
        -- See :help oil-columns
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
            -- Set to true to autosave buffers that are updated with LSP willRenameFiles
            -- Set to "unmodified" to only save unmodified buffers
            autosave_changes = true,
        },
        -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
        delete_to_trash = false,
        -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
        skip_confirm_for_simple_edits = false,
        -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
        -- (:help prompt_save_on_select_new_entry)
        prompt_save_on_select_new_entry = true,
        -- Oil will automatically delete hidden buffers after this delay
        -- You can set the delay to false to disable cleanup entirely
        -- Note that the cleanup process only starts when none of the oil buffers are currently displayed
        cleanup_delay_ms = 2000,
        -- Constrain the cursor to the editable parts of the oil buffer
        -- Set to `false` to disable, or "name" to keep it on the file names
        constrain_cursor = false,
        win_options = {
            wrap = false,
            signcolumn = "yes:2",
            cursorcolumn = false,
            foldcolumn = "0",
            spell = false,
            list = false,
            conceallevel = 3,
            concealcursor = "nvic",
        },
        view_options = {
            -- Show files and directories that start with "."
            show_hidden = false,
            -- This function defines what is considered a "hidden" file
            is_hidden_file = function(name, bufnr)
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
            -- This function defines what will never be shown, even when `show_hidden` is set
            is_always_hidden = function(name, bufnr)
                return name == "." or name == ".."
            end,
            sort = {
                -- sort order can be "asc" or "desc"
                -- see :help oil-columns to see which columns are sortable
                { "type", "asc" },
                { "name", "asc" },
            },
        },
    },
    config = function(_, opts)
        require("oil").setup(opts)

        require("oil-git-status").setup({
            show_ignored = true,
        })

        require("oil-lsp-diagnostics").setup()
    end,
}

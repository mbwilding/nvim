return {
    "nvim-telescope/telescope.nvim",
    -- branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        "aaronhallaert/advanced-git-search.nvim",
        "debugloop/telescope-undo.nvim",
        "nvim-telescope/telescope-media-files.nvim",
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
        -- "cbochs/grapple.nvim",
    },
    config = function()
        local actions = require("telescope.actions")

        local extensions = {
            ["fzf"] = {},
            ["undo"] = {},
            ["package_info"] = {},
            ["persisted"] = {},
            ["ui-select"] = {
                require("telescope.themes").get_dropdown(),
            },
            ["advanced_git_search"] = {
                -- fugitive or diffview
                diff_plugin = "diffview",
                -- customize git in previewer
                -- e.g. flags such as { "--no-pager" }, or { "-c", "delta.side-by-side=false" }
                git_flags = {},
                -- customize git diff in previewer
                -- e.g. flags such as { "--raw" }
                git_diff_flags = {},
                -- Show builtin git pickers when executing "show_custom_functions" or :AdvancedGitSearch
                show_builtin_git_pickers = false,
                entry_default_author_or_date = "author",     -- one of "author" or "date"

                -- Telescope layout setup
                telescope_theme = {
                    function_name_1 = {
                        -- Theme options
                    },
                    function_name_2 = "dropdown",
                    -- e.g. realistic example
                    show_custom_functions = {
                        layout_config = { width = 0.4, height = 0.4 },
                    },
                },
            },
            ["media_files"] = {
                filetypes = { "png", "webp", "jpg", "jpeg" },
                find_cmd = "rg",
            },
            -- ["noice"] = {},
            -- ["grapple"] = {},
        }

        require("telescope").setup({
            pickers = {
                find_files = {
                    hidden = true,
                },
            },
            defaults = {
                mappings = {
                    n = {
                        ['<C-d>'] = actions.delete_buffer
                    },
                    i = {
                        ['<C-d>'] = actions.delete_buffer
                    }
                },
                vimgrep_arguments = {
                    "rg",
                    "--hidden",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                },
                file_ignore_patterns = {
                    ".DS_Store",
                    ".git/",
                    ".git\\",
                    "node_modules/",
                    "node_modules\\",
                    "vendor/",
                    "vendor\\",
                    "build/",
                    "build\\",
                    "dist/",
                    "dist\\",
                    "target/",
                    "target\\",
                    ".cache/",
                    ".cache\\",
                    ".vscode/",
                    ".vscode\\",
                    ".vs/",
                    ".vs\\",
                    ".idea/",
                    ".idea\\",
                    ".next/",
                    ".next\\",
                    "package-lock.json",
                    "packages.lock.json",
                },
            },
            extensions = extensions
        })

        for key, _ in pairs(extensions) do
            pcall(require("telescope").load_extension, key)
        end

        -- See `:help telescope.builtin`
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Telescope: Search help" })
        vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Telescope: Search keymaps" })
        vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Telescope: Search by grep" })
        vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Telescope: Search files" })
        vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "Telescope: Search Select" })
        vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Telescope: Search current word" })
        vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Telescope: Search diagnostics" })
        vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "Telescope: Search resume" })
        vim.keymap.set(
            "n",
            "<leader>s.",
            builtin.oldfiles,
            { desc = 'Telescope: Search Recent Files ("." for repeat)' }
        )
        vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Telescope: Find existing buffers" })

        -- Slightly advanced example of overriding default behavior and theme
        vim.keymap.set("n", "<leader>/", function()
            -- You can pass additional configuration to telescope to change theme, layout, etc.
            builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                winblend = 10,
                previewer = false,
            }))
        end, { desc = "Telescope: Fuzzily search in current buffer" })

        -- Also possible to pass additional configuration options.
        --  See `:help telescope.builtin.live_grep()` for information about particular keys
        vim.keymap.set("n", "<leader>s/", function()
            builtin.live_grep({
                grep_open_files = true,
                prompt_title = "Telescope: Live grep in open files",
            })
        end, { desc = "Telescope: Search in open files" })

        -- Search Neovim config content
        vim.keymap.set("n", "<leader>sn", function()
            builtin.live_grep({ cwd = vim.fn.stdpath("config") })
        end, { desc = "Telescope: Search Neovim content" })

        -- Search Neovim config files
        vim.keymap.set("n", "<leader>sN", function()
            builtin.find_files({ cwd = vim.fn.stdpath("config") })
        end, { desc = "Telescope: Search Neovim files" })

        -- Advanced Git Search
        vim.keymap.set(
            "n",
            "<leader>sG",
            "<cmd>AdvancedGitSearch<CR>",
            { silent = true, desc = "Telescope: Advanced git search" }
        )

        -- Undo
        vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<CR>", { silent = true, desc = "Telescope: Undo history" })
    end,
}

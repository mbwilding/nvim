return {
    'saecki/crates.nvim',
    tag = "unstable",
    event = { "BufRead Cargo.toml" },
    config = function()
        local crates = require("crates")
        crates.setup {
            smart_insert = true,
            insert_closing_quote = true,
            autoload = true,
            autoupdate = true,
            autoupdate_throttle = 250,
            loading_indicator = true,
            date_format = "%Y-%m-%d",
            thousands_separator = ".",
            notification_title = "crates.nvim",
            curl_args = { "-sL", "--retry", "1" },
            max_parallel_requests = 80,
            open_programs = { "xdg-open", "open" },
            expand_crate_moves_cursor = true,
            disable_invalid_feature_diagnostic = false,
            enable_update_available_warning = true,
            on_attach = function(bufnr) end,
            text = {
                loading = "   Loading",
                version = "   %s",
                prerelease = "   %s",
                yanked = "   %s",
                nomatch = "   No match",
                upgrade = "   %s",
                error = "   Error fetching crate",
            },
            highlight = {
                loading = "CratesNvimLoading",
                version = "CratesNvimVersion",
                prerelease = "CratesNvimPreRelease",
                yanked = "CratesNvimYanked",
                nomatch = "CratesNvimNoMatch",
                upgrade = "CratesNvimUpgrade",
                error = "CratesNvimError",
            },
            popup = {
                autofocus = true,
                hide_on_select = false,
                copy_register = '"',
                style = "minimal",
                border = "none",
                show_version_date = false,
                show_dependency_version = true,
                max_height = 30,
                min_width = 20,
                padding = 1,
                text = {
                    title = " %s",
                    pill_left = "",
                    pill_right = "",
                    description = "%s",
                    created_label = " created        ",
                    created = "%s",
                    updated_label = " updated        ",
                    updated = "%s",
                    downloads_label = " downloads      ",
                    downloads = "%s",
                    homepage_label = " homepage       ",
                    homepage = "%s",
                    repository_label = " repository     ",
                    repository = "%s",
                    documentation_label = " documentation  ",
                    documentation = "%s",
                    crates_io_label = " crates.io      ",
                    crates_io = "%s",
                    categories_label = " categories     ",
                    keywords_label = " keywords       ",
                    version = "  %s",
                    prerelease = " %s",
                    yanked = " %s",
                    version_date = "  %s",
                    feature = "  %s",
                    enabled = " %s",
                    transitive = " %s",
                    normal_dependencies_title = " Dependencies",
                    build_dependencies_title = " Build dependencies",
                    dev_dependencies_title = " Dev dependencies",
                    dependency = "  %s",
                    optional = " %s",
                    dependency_version = "  %s",
                    loading = "  ",
                },
                highlight = {
                    title = "CratesNvimPopupTitle",
                    pill_text = "CratesNvimPopupPillText",
                    pill_border = "CratesNvimPopupPillBorder",
                    description = "CratesNvimPopupDescription",
                    created_label = "CratesNvimPopupLabel",
                    created = "CratesNvimPopupValue",
                    updated_label = "CratesNvimPopupLabel",
                    updated = "CratesNvimPopupValue",
                    downloads_label = "CratesNvimPopupLabel",
                    downloads = "CratesNvimPopupValue",
                    homepage_label = "CratesNvimPopupLabel",
                    homepage = "CratesNvimPopupUrl",
                    repository_label = "CratesNvimPopupLabel",
                    repository = "CratesNvimPopupUrl",
                    documentation_label = "CratesNvimPopupLabel",
                    documentation = "CratesNvimPopupUrl",
                    crates_io_label = "CratesNvimPopupLabel",
                    crates_io = "CratesNvimPopupUrl",
                    categories_label = "CratesNvimPopupLabel",
                    keywords_label = "CratesNvimPopupLabel",
                    version = "CratesNvimPopupVersion",
                    prerelease = "CratesNvimPopupPreRelease",
                    yanked = "CratesNvimPopupYanked",
                    version_date = "CratesNvimPopupVersionDate",
                    feature = "CratesNvimPopupFeature",
                    enabled = "CratesNvimPopupEnabled",
                    transitive = "CratesNvimPopupTransitive",
                    normal_dependencies_title = "CratesNvimPopupNormalDependenciesTitle",
                    build_dependencies_title = "CratesNvimPopupBuildDependenciesTitle",
                    dev_dependencies_title = "CratesNvimPopupDevDependenciesTitle",
                    dependency = "CratesNvimPopupDependency",
                    optional = "CratesNvimPopupOptional",
                    dependency_version = "CratesNvimPopupDependencyVersion",
                    loading = "CratesNvimPopupLoading",
                },
                keys = {
                    hide = { "q", "<esc>" },
                    open_url = { "<cr>" },
                    select = { "<cr>" },
                    select_alt = { "s" },
                    toggle_feature = { "<cr>" },
                    copy_value = { "yy" },
                    goto_item = { "gd", "K", "<C-LeftMouse>" },
                    jump_forward = { "<c-i>" },
                    jump_back = { "<c-o>", "<C-RightMouse>" },
                },
            },
            src = {
                insert_closing_quote = true,
                text = {
                    prerelease = "  pre-release ",
                    yanked = "  yanked ",
                },
                cmp = {
                    enabled = true,
                    use_custom_kind = true,
                    kind_text = {
                        version = "Version",
                        feature = "Feature",
                    },
                    kind_highlight = {
                        version = "CmpItemKindVersion",
                        feature = "CmpItemKindFeature",
                    },
                },
                coq = {
                    enabled = false,
                    name = "crates.nvim",
                },
            },
            null_ls = {
                enabled = false,
                name = "crates.nvim",
            },
            lsp = {
                enabled = true,
                name = "crates.nvim",
                on_attach = function(client, bufnr) end,
                actions = true,
                completion = true,
                hover = true,
            },
        }

        vim.api.nvim_create_autocmd("BufRead", {
            group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
            pattern = "Cargo.toml",
            callback = function()
                cmp.setup.buffer({ sources = { { name = "crates" } } })
            end,
        })

        vim.keymap.set("n", "<leader>rt", crates.toggle, { silent = true, desc = "Crates: Toggle" })
        vim.keymap.set("n", "<leader>rr", crates.reload, { silent = true, desc = "Crates: Reload" })

        vim.keymap.set("n", "<leader>rv", crates.show_versions_popup, { silent = true, desc = "Crates: Versions popup" })
        vim.keymap.set("n", "<leader>rf", crates.show_features_popup, { silent = true, desc = "Crates: Features popup" })
        vim.keymap.set("n", "<leader>rd", crates.show_dependencies_popup,
            { silent = true, desc = "Crates: Dependencies Popup" })

        vim.keymap.set("n", "<leader>ru", crates.update_crate, { silent = true, desc = "Crates: Update" })
        vim.keymap.set("v", "<leader>ru", crates.update_crates, { silent = true, desc = "Crates: Update selected" })
        vim.keymap.set("n", "<leader>ra", crates.update_all_crates, { silent = true, desc = "Crates: Update all" })
        vim.keymap.set("n", "<leader>rU", crates.upgrade_crate, { silent = true, desc = "Crates: Upgrade" })
        vim.keymap.set("v", "<leader>rU", crates.upgrade_crates, { silent = true, desc = "Crates: Upgrade selected" })
        vim.keymap.set("n", "<leader>rA", crates.upgrade_all_crates, { silent = true, desc = "Crates: Upgrade all" })

        vim.keymap.set("n", "<leader>rx", crates.expand_plain_crate_to_inline_table,
            { silent = true, desc = "Crates: Expand to table" })
        vim.keymap.set("n", "<leader>rX", crates.extract_crate_into_table,
            { silent = true, desc = "Crates: Extract into table" })

        --vim.keymap.set("n", "<leader>roh", crates.open_homepage, { silent = true, desc = "Crates: Homepage" })
        --vim.keymap.set("n", "<leader>ror", crates.open_repository, { silent = true, desc = "Crates: Repository" })
        --vim.keymap.set("n", "<leader>rod", crates.open_documentation, { silent = true, desc = "Crates: Documentation" })
        --vim.keymap.set("n", "<leader>roc", crates.open_crates_io, { silent = true, desc = "Crates: IO" })
    end
}

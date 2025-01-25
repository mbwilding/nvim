return {
    "kperath/dailynotes.nvim",
    lazy = true,
    keys = {
        {
            "<leader>dnt",
            "<CMD>Daily<CR>",
            desc = "DailyNotes: Today",
        },
        {
            "<leader>dnn",
            "<CMD>DailyNext<CR>",
            desc = "DailyNotes: Next",
        },
        {
            "<leader>dnp",
            "<CMD>DailyPrev<CR>",
            desc = "DailyNotes: Prev",
        },
    },
    opts = {
        path = "~/notes/",
    },
    config = function(_, opts)
        -- Add autocommand for git commit on save
        local path = vim.fn.expand(opts.path)
        local group = "DailyNotesGit"
        vim.api.nvim_create_augroup(group, { clear = true })
        vim.api.nvim_create_autocmd("BufWritePost", {
            group = group,
            pattern = path .. "**",
            callback = function()
                local datetime = os.date("%Y-%m-%d-%H-%M-%S")
                local cmd = 'git add . && if ! git diff-index --quiet HEAD --; then git commit -m "' .. datetime .. '" && git pull --rebase && git push; fi'
                vim.fn.jobstart(
                    cmd,
                    {
                        cwd = path,
                        -- on_stdout = function(_, data)
                        --     if data then
                        --         vim.notify(table.concat(data, "\n"), vim.log.levels.INFO)
                        --     end
                        -- end,
                        on_exit = function(_, code, _)
                            if code == 0 then
                                vim.notify("Synced", vim.log.levels.INFO)
                            else
                                vim.notify("Syncing failed", vim.log.levels.ERROR)
                            end
                        end,
                    }
                )
            end,
        })

        require("dailynotes").setup(opts)
    end,
}

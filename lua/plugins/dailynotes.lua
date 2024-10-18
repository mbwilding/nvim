return {
    "kperath/dailynotes.nvim",
    lazy = true,
    opts = {
        path = "~/notes/",
    },
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
    config = function(_, opts)
        require("dailynotes").setup(opts)

        -- Add autocommand for git commit on save
        local group = "DailyNotesGit"
        vim.api.nvim_create_augroup(group, { clear = true })
        vim.api.nvim_create_autocmd("BufWritePost", {
            group = group,
            pattern = vim.fn.expand(opts.path) .. "**",
            callback = function()
                vim.fn.jobstart('git -C ' .. vim.fn.expand(opts.path) .. ' add . && git -C ' .. vim.fn.expand(opts.path) .. ' commit -m "' .. os.date('%Y-%m-%d-%H-%M-%S') .. '" && git -C ' .. vim.fn.expand(opts.path) .. ' push', {
                    on_stdout = function(_, data)
                        if data then
                            vim.api.nvim_out_write(table.concat(data, "\n") .. "\n")
                        end
                    end,
                    on_exit = function(_, code, _)
                        if code == 0 then
                            vim.api.nvim_out_write("Push successful\n")
                        else
                            vim.api.nvim_err_writeln("Push failed")
                        end
                    end,
                })
            end,
        })
    end
}

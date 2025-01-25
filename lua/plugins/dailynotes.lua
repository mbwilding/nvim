return {
    "kperath/dailynotes.nvim",
    dependencies = {
        "taybart/b64.nvim",
    },
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
        -- -- Add autocommand for git commit on save
        -- local path = vim.fn.expand(opts.path)
        -- local group = "DailyNotesGit"
        -- vim.api.nvim_create_augroup(group, { clear = true })
        -- vim.api.nvim_create_autocmd("BufWritePost", {
        --     group = group,
        --     pattern = path .. "**",
        --     callback = function()
        --         local datetime = os.date("%Y-%m-%d-%H-%M-%S")
        --         local cmd = 'git add . && if ! git diff-index --quiet HEAD --; then git commit -m "' .. datetime .. '" && git pull --rebase && git push; fi'
        --         vim.fn.jobstart(
        --             cmd,
        --             {
        --                 cwd = path,
        --                 -- on_stdout = function(_, data)
        --                 --     if data then
        --                 --         vim.notify(table.concat(data, "\n"), vim.log.levels.INFO)
        --                 --     end
        --                 -- end,
        --                 on_exit = function(_, code, _)
        --                     if code == 0 then
        --                         vim.notify("Synced", vim.log.levels.INFO)
        --                     else
        --                         vim.notify("Syncing failed", vim.log.levels.ERROR)
        --                     end
        --                 end,
        --             }
        --         )
        --     end,
        -- })

        -- Add autocommand for git commit on save
        local path = vim.fn.expand(opts.path)
        local group = "DailyNotesGit"
        vim.api.nvim_create_augroup(group, { clear = true })
        vim.api.nvim_create_autocmd("BufWritePost", {
            group = group,
            pattern = path .. "**",
            callback = function(event)
                local repo_path = vim.fn.expand(opts.path)
                local origin = vim.trim(vim.fn.system("git -C " .. repo_path .. " config --get remote.origin.url"))
                local is_github = origin:match("github.com") ~= nil

                if not is_github then
                    return
                end

                local content = table.concat(vim.api.nvim_buf_get_lines(event.buf, 0, -1, false), "\n")
                local file_name = vim.fn.fnamemodify(event.file, ":t")

                local owner, repository = origin:match("github.com[:/]([^/]+)/([^/]+)")
                local url = "repos/" .. owner .. "/" .. repository .. "/contents/" .. file_name

                vim.fn.jobstart("gh api " .. url, {
                    on_stdout = function(_, data)
                        local b64 = require("b64")
                        local content_b64 = b64.enc(content)

                        local response = table.concat(data, "\n")
                        local decoded = vim.json.decode(response)
                        if decoded.status == "404" then
                            -- File not exist
                        else
                            -- File exist
                            local sha_remote = decoded.sha
                            local content_remote_b64 = decoded.content
                            local content_remote = b64.dec(decoded.content)
                        end
                    end,
                    stdout_buffered = true,
                })
            end,
        })

        require("dailynotes").setup(opts)
    end,
}

vim.api.nvim_create_user_command("Push", function()
    vim.fn.jobstart("git add . && git commit -m \"" .. os.date("%Y-%m-%d-%H-%M-%S") .. "\" && git push", {
        on_stdout = function(_, data)
            if data then
                vim.notify(table.concat(data, "\n"), vim.log.levels.INFO)
            end
        end,
        on_stderr = function(_, data)
            if data then
                vim.notify(table.concat(data, "\n"), vim.log.levels.ERROR)
            end
        end,
        on_exit = function(_, code, _)
            if code == 0 then
                vim.notify("Push successful")
            else
                vim.notify("Push failed", vim.log.levels.ERROR)
            end
        end,
    })

end, {})

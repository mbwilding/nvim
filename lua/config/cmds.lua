vim.api.nvim_create_user_command("Push", function()
    vim.fn.jobstart("git add . && git commit -m \"" .. os.date("%Y-%m-%d-%H-%M-%S") .. "\" && git push", {
        on_stdout = function(_, data)
            if data then
                local message = table.concat(data, "\n")
                if message:find("nothing to commit") then
                    vim.notify("No changes", vim.log.levels.WARN)
                else
                    vim.notify(message, vim.log.levels.INFO)
                end
            end
        end,
        on_exit = function(_, code, _)
            if code == 0 then
                vim.notify("Push successful")
            -- else
            --     vim.notify("Push failed", vim.log.levels.ERROR)
            end
        end,
    })
end, {})

local owner = "mbwilding"
local repository = "notes"
local url_base = "repos/" .. owner .. "/" .. repository .. "/contents/"

vim.api.nvim_create_user_command("NoteToday", function()
    local sha
    local file = os.date("%Y-%m-%d") .. ".md"
    vim.fn.jobstart("gh api " .. url_base .. file, {
        stdout_buffered = true,
        on_stdout = function(_, data_load)
            local buf = vim.api.nvim_create_buf(true, false)
            vim.api.nvim_buf_set_name(buf, file)
            vim.bo[buf].filetype = "markdown"
            vim.bo[buf].buftype = 'acwrite'
            vim.api.nvim_win_set_buf(0, buf)

            local response = table.concat(data_load, "\n")
            local decoded = vim.json.decode(response)

            if decoded.status ~= "404" then
                sha = decoded.sha
                local content = require("b64").dec(decoded.content)
                local lines = vim.split(content, '\n')
                vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
            end

            -- Set up autocmd for BufWriteCmd to override :w (save) command for this buffer
            vim.api.nvim_create_autocmd("BufWriteCmd", {
                buffer = buf,
                callback = function()
                    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
                    local content = table.concat(lines, "\n")
                    local content_b64 = require("b64").enc(content)

                    local cmd = "gh api " ..
                        url_base .. file .. " --method PUT -f message='" .. "updated" .. "' -f content=" .. content_b64
                    if sha then
                        cmd = cmd .. " -f sha=" .. sha
                    end

                    vim.fn.jobstart(cmd, {
                        stdout_buffered = true,
                        on_stdout = function(_, data_save)
                            sha = vim.json.decode(table.concat(data_save, "\n")).content.sha
                        end,
                        on_exit = function(_, exit_code)
                            if exit_code == 0 then
                                vim.notify("Updated", "info")
                            else
                                vim.notify("Error uploading", "error")
                            end
                        end,
                    })
                end,
            })
        end,
    })
end, {})

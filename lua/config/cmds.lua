vim.api.nvim_create_user_command("Push", function()
    local function log(_, data)
        if data then
            local message = table.concat(data, "\n")
            if message:find("nothing to commit") then
                vim.notify("No changes", vim.log.levels.WARN)
            else
                vim.notify(message, vim.log.levels.INFO)
            end
        end
    end

    vim.fn.jobstart("git add . && git commit -m \"" .. os.date("%Y-%m-%d-%H-%M-%S") .. "\" && git push", {
        on_stdout = log,
        on_stderr = log,
        on_exit = function(_, code, _)
            if code == 0 then
                vim.notify("Push successful")
            else
                vim.notify("Push failed", vim.log.levels.ERROR)
            end
        end,
    })
end, {})

vim.api.nvim_create_user_command("JsonConvert", function()
    local filetype_to_lang = {
        cs = { lang = "csharp", args = "--framework SystemTextJson --csharp-version 6 --array-type list --number-type decimal --any-type object --features attributes-only" },
        go = { lang = "golang", args = "" },
        rust = { lang = "rust", args = "--visibility public --derive-debug --derive-clone --derive-partial-eq --leading-comments" },
        typescript = { lang = "typescript", args = "--just-types --nice-property-names --explicit-unions --acronym-style camel" },
    }

    local function quicktype(lang)
        local clipboard = vim.fn.getreg('+')
        local tmp = vim.fn.tempname() .. '.json'
        local f = io.open(tmp, 'w')
        if not f then
            vim.notify('Cannot write to file', vim.log.levels.ERROR)
            return
        end
        f:write(clipboard)
        f:close()

        local cmd = 'quicktype ' ..
        tmp .. ' --alphabetize-properties --no-maps --lang ' .. lang.lang .. ' ' .. lang.args .. ' 2>&1'
        local output = vim.fn.systemlist(cmd)

        if vim.v.shell_error ~= 0 then
            vim.notify(table.concat(output, '\n'), vim.log.levels.ERROR)
            return
        end

        for i, line in ipairs(output) do
            output[i] = line:gsub('%s+$', '')
        end

        local pos = vim.api.nvim_win_get_cursor(0)
        local row = pos[1] - 1
        vim.api.nvim_buf_set_lines(0, row, row, false, output)
        vim.api.nvim_win_set_cursor(0, pos)
    end

    local file_type = vim.bo.filetype
    local lang = filetype_to_lang[file_type] or file_type
    if lang then
        quicktype(lang)
    else
        vim.notify("Unsupported file type", vim.log.levels.ERROR)
    end
end, {})

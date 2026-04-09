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

        if lang.lang == 'csharp' then
            -- Format for scoped namespace
            output[1] = output[1] .. ';'
            output[2] = ''
            output[#output] = ''
            for i, line in ipairs(output) do
                if line:find('^%s') then
                    output[i] = line:sub(5)
                else
                    output[i] = line
                end
                output[i] = output[i]:gsub('%s+$', '')
            end
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


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

local inspector_enabled = false
local inspector = "inspector"
local inspector_close_float = nil
local function inspect()
    local augroup = vim.api.nvim_create_augroup(inspector, { clear = true })
    local ns = vim.api.nvim_create_namespace(inspector)
    local float_buf = nil
    local float_win = nil

    local function close_float()
        if float_win and vim.api.nvim_win_is_valid(float_win) then
            vim.api.nvim_win_close(float_win, true)
        end

        if float_buf and vim.api.nvim_buf_is_valid(float_buf) then
            vim.api.nvim_buf_delete(float_buf, { force = true })
        end

        float_win = nil
        float_buf = nil
    end

    inspector_close_float = close_float

    local function open_float(parts)
        close_float()

        float_buf = vim.api.nvim_create_buf(false, true)
        vim.bo[float_buf].bufhidden = "wipe"

        vim.api.nvim_buf_set_lines(float_buf, 0, -1, false, parts)

        for i, name in ipairs(parts) do
            if not name:match("^->") then
                vim.hl.range(float_buf, ns, name, { i - 1, 0 }, { i - 1, -1 }, nil)
            end
        end

        local width = 0
        for _, name in ipairs(parts) do
            width = math.max(width, #name)
        end

        local ui = vim.api.nvim_list_uis()[1]
        local total_w = ui and ui.width or vim.o.columns
        local total_h = ui and ui.height or vim.o.lines

        float_win = vim.api.nvim_open_win(float_buf, false, {
            relative = "editor",
            width = width,
            height = #parts,
            col = total_w - width,
            row = total_h - #parts - 1,
            style = "minimal",
            border = "none",
            focusable = false,
            zindex = 250,
        })
    end

    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        group = augroup,
        callback = function()
            local buf = vim.api.nvim_get_current_buf()
            local row, col = unpack(vim.api.nvim_win_get_cursor(0))

            local entries = {}

            local function add(name, priority)
                if name and name ~= "" then
                    table.insert(entries, { name = name, priority = priority })
                end
            end

            local ok, info = pcall(vim.inspect_pos, buf, row - 1, col)
            if ok and info then
                for _, cap in ipairs(info.treesitter or {}) do
                    add("@" .. cap.capture, cap.priority or 100)
                end
                for _, token in ipairs(info.semantic_tokens or {}) do
                    if token.type then
                        add("@lsp.type." .. token.type, 200)
                        for _, mod in ipairs(token.modifiers or {}) do
                            add("@lsp.mod." .. mod, 200)
                            add("@lsp.typemod." .. token.type .. "." .. mod, 200)
                        end
                    end
                end
                for _, ext in ipairs(info.extmarks or {}) do
                    if ext.opts and ext.opts.hl_group then
                        add(ext.opts.hl_group, ext.opts.priority or 0)
                    end
                end
                for _, syn in ipairs(info.syntax or {}) do
                    add(syn.hl_group, 50)
                    if syn.hl_group_link and syn.hl_group_link ~= syn.hl_group then
                        add("->" .. syn.hl_group_link, 50)
                    end
                end
            end

            table.sort(entries, function(a, b)
                return a.priority > b.priority
            end)

            local parts = {}
            local seen = {}
            for _, entry in ipairs(entries) do
                if not seen[entry.name] then
                    seen[entry.name] = true
                    table.insert(parts, entry.name)
                end
            end

            if #parts > 0 then
                open_float(parts)
            else
                close_float()
            end
        end,
    })

    vim.api.nvim_create_autocmd("VimLeavePre", {
        group = augroup,
        callback = function()
            close_float()
        end,
    })
end

local function enable_inspector()
    if not inspector_enabled then
        inspect()
        inspector_enabled = true
    end
end

local function disable_inspector()
    if inspector_enabled then
        pcall(vim.api.nvim_del_augroup_by_name, inspector)
        if inspector_close_float then
            inspector_close_float()
            inspector_close_float = nil
        end
        inspector_enabled = false
    end
end

vim.api.nvim_create_user_command("InspectOn", function()
    enable_inspector()
end, {})

vim.api.nvim_create_user_command("InspectOff", function()
    disable_inspector()
end, {})

vim.api.nvim_create_user_command("InspectToggle", function()
    if inspector_enabled then
        disable_inspector()
    else
        enable_inspector()
    end
end, {})

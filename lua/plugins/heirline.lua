return {
    "rebelot/heirline.nvim",
    lazy = true,
    event = "BufEnter",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        vim.o.showmode = false
        vim.o.showcmd = false

        local conditions = require("heirline.conditions")
        local utils = require("heirline.utils")
        local colors = require("gronk.colors")
        require("heirline").load_colors(colors)

        local null = "-"

        local icons = true

        -- HELPERS
        local function spacer(bg)
            return {
                provider = " ",
                hl = { bg = bg },
            }
        end

        local vspacer = { provider = " | " }

        local cut = { provider = "%<" }

        local align = { provider = "%=" }

        local align_cut = { provider = "%<%=" }

        local open = { provider = "[" }

        local close = { provider = "]" }

        -- MODE
        local mode_name = {
            n = "NORMAL",
            no = "OPERATOR-PENDING",
            nov = "OPERATOR-PENDING VISUAL",
            noV = "OPERATOR-PENDING VISUAL LINE",
            ["no\22"] = "OPERATOR-PENDING VISUAL BLOCK",
            niI = "NORMAL INSERT",
            niR = "NORMAL REPLACE",
            niV = "NORMAL VIRTUAL",
            nt = "TERMINAL",
            v = "VISUAL",
            vs = "VISUAL SELECT",
            V = "VISUAL LINE",
            Vs = "VISUAL LINE SELECT",
            ["\22"] = "VISUAL BLOCK",
            ["\22s"] = "VISUAL BLOCK SELECT",
            s = "SELECT",
            S = "SELECT LINE",
            ["\19"] = "SELECT BLOCK",
            i = "INSERT",
            ic = "INSERT COMPLETION",
            ix = "INSERT XTERM",
            R = "REPLACE",
            Rc = "REPLACE COMPLETION",
            Rx = "REPLACE XTERM",
            Rv = "VIRTUAL REPLACE",
            Rvc = "VIRTUAL REPLACE COMPLETION",
            Rvx = "VIRTUAL REPLACE XTERM",
            c = "COMMAND-LINE",
            cv = "EX MODE",
            r = "HIT-ENTER PROMPT",
            rm = "MORE PROMPT",
            ["r?"] = "CONFIRM",
            ["!"] = "SHELL or EXTERNAL COMMAND",
            t = "TERMINAL",
        }

        local mode_colors = {
            n = colors.namespace,
            i = colors.macro,
            v = colors.method,
            [""] = colors.keyword,
            V = colors.method,
            c = colors.namespace,
            no = colors.member,
            s = colors.namespace,
            S = colors.namespace,
            [""] = colors.namespace,
            ic = colors.keyword,
            R = colors.number,
            Rv = colors.number,
            cv = colors.member,
            ce = colors.member,
            r = colors.member,
            rm = colors.member,
            ["r?"] = colors.member,
            ["!"] = colors.member,
            t = colors.member,
            nt = colors.member,
        }

        local mode_info = function()
            local mode = vim.fn.mode(1)
            local letter = mode:sub(1, 1)
            local name = mode_name[mode]:match("%S+")
            local color = mode_colors[mode]

            return {
                mode = mode,
                letter = letter,
                name = name,
                color = color,
            }
        end

        local function vim_mode(bg)
            return {
                init = function(self)
                    self.mode_info = mode_info()
                end,
                provider = function(self)
                    return "%2(" .. self.mode_info.name .. "%)"
                end,
                hl = function(self)
                    return { fg = self.mode_info.color, bg = bg, bold = true }
                end,
                update = {
                    "ModeChanged",
                    pattern = "*:*",
                    callback = vim.schedule_wrap(function()
                        vim.cmd("redrawstatus")
                    end),
                },
            }
        end

        -- FILE
        local file_name_block = {
            init = function(self)
                self.filename = vim.api.nvim_buf_get_name(0)
                --self.show_name_ext_only = true
            end,
            hl = function()
                return { fg = colors.fg, bg = colors.none }
            end,
        }

        local file_icon = {
            init = function(self)
                local path = vim.fn.expand("%:p")
                local devicons_ok, devicons = pcall(require, "nvim-web-devicons")
                if not devicons_ok then
                    self.icon = " " -- Default icon
                    self.icon_color = "#6d8086" -- Default color
                    return
                end

                -- Try to find icon using the filename
                local icon, icon_color =
                    devicons.get_icon_color(vim.fs.basename(path), vim.fn.fnamemodify(path, ":e"), { default = false })

                -- If no icon is found, try finding it using the filetype
                if not icon then
                    local buf = vim.iter(vim.api.nvim_list_bufs()):find(function(buf)
                        return vim.api.nvim_buf_get_name(buf) == path
                    end)
                    if buf then
                        local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf })
                        icon, icon_color = devicons.get_icon_by_filetype(filetype)
                    end
                end

                -- Fallback to default icon if none is found
                self.icon = icon and icon .. " " or " "
                self.icon_color = icon_color or "#6d8086"
            end,
            provider = function(self)
                return self.icon
            end,
            hl = function(self)
                return { fg = self.icon_color, bg = colors.none }
            end,
        }

        local file_name = {
            provider = function(self)
                local home = vim.fn.expand("~")
                local filename = vim.fn.fnamemodify(self.filename, ":.")

                filename = filename:gsub("oil://", "")

                if filename:sub(1, #home) == home then
                    filename = "~" .. filename:sub(#home + 1)
                end

                if not conditions.width_percent_below(#filename, 0.25) then
                    filename = vim.fn.fnamemodify(filename, ":t")
                end

                return "[" .. filename .. "]"
            end,
            hl = function()
                return { fg = colors.string, bg = colors.none, force = true }
            end,
        }

        local file_name_modifier = {
            hl = function()
                if vim.bo.modified then
                    return { fg = colors.number, bg = colors.none, force = true }
                elseif vim.bo.readonly or not vim.bo.modifiable then
                    return { fg = colors.error, bg = colors.none, force = true }
                end
            end,
        }

        file_name_block = utils.insert(
            file_name_block,
            -- file_icon,
            -- utils.insert(file_name_modifier, file_name),
            { provider = "%<" } -- this means that the statusline is cut here when there's not enough space
        )

        -- FILE INFO (size, format, encoding, type — each as its own section)
        local function file_size(bg)
            return {
                provider = function()
                    local suffix = { "B", "KB", "MB", "GB", "TB", "PB", "EB" }
                    local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
                    fsize = (fsize < 0 and 0) or fsize
                    if fsize == 0 then return "  " .. null end
                    if fsize < 1024 then return "  " .. fsize .. suffix[1] end
                    local i = math.floor((math.log(fsize) / math.log(1024)))
                    return "  " .. string.format("%.2f%s", fsize / (1024 ^ i), suffix[i + 1])
                end,
                hl = { fg = colors.module, bg = bg },
            }
        end

        local function file_format(bg)
            return {
                provider = function()
                    local format = vim.bo.fileformat

                    if vim.bo.filetype == "oil" then
                        return " " .. null
                    end

                    if format == "unix" then
                        return " LF"
                    elseif format == "dos" then
                        return " CRLF"
                    elseif format == "mac" then
                        return " CR"
                    else
                        return format:upper()
                    end
                end,
                hl = { fg = colors.method, bg = bg },
            }
        end

        local function file_encoding(bg)
            return {
                provider = function()
                    local enc = vim.bo.fenc
                    if enc ~= "" then
                        local has_bom = vim.bo.bomb and " " or ""
                        return "  " .. enc:upper() .. has_bom
                    end
                    return "  " .. null
                end,
                hl = { fg = colors.keyword, bg = bg },
            }
        end

        local function file_type(bg)
            return {
                provider = function()
                    local path = vim.api.nvim_buf_get_name(0)
                    local ft = vim.bo.filetype
                    local devicons_ok, devicons = pcall(require, "nvim-web-devicons")
                    local icon = ""
                    if devicons_ok then
                        local di = devicons.get_icon(vim.fs.basename(path), vim.fn.fnamemodify(path, ":e"),
                            { default = false })
                        if not di then
                            di = devicons.get_icon_by_filetype(ft, { default = false })
                        end
                        if di then icon = di end
                    end
                    local label = ft ~= "" and ft or null
                    return icon .. "  " .. label
                end,
                hl = { fg = colors.number, bg = bg },
            }
        end

        -- FILE LAST MODIFIED
        local file_last_modified = {
            -- did you know? Vim is full of functions!
            provider = function()
                local ftime = vim.fn.getftime(vim.api.nvim_buf_get_name(0))
                return (ftime > 0) and os.date("%c", ftime)
            end,
            hl = { bg = colors.none },
        }

        -- RULER
        local function ruler(bg)
            return {
                -- %l = current line number
                -- %L = number of lines in the buffer
                -- %c = column number
                -- %P = percentage through file of displayed window

                -- static = {
                --     --sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" },
                --     sbar = {
                --         "",
                --         "",
                --         "",
                --         "",
                --         "",
                --         "",
                --         "",
                --         "",
                --         "",
                --         "",
                --         "",
                --         "",
                --         "",
                --         "",
                --         "",
                --     },
                -- },
                provider = function(self)
                    -- local curr_line = vim.api.nvim_win_get_cursor(0)[1]
                    -- local lines = vim.api.nvim_buf_line_count(0)
                    -- local i
                    -- if lines == 1 then
                    --   i = #self.sbar
                    -- else
                    --   i = math.floor((curr_line - 1) / (lines - 1) * (#self.sbar - 1)) + 1
                    -- end
                    -- local icon = string.rep(self.sbar[i], 1)
                    return "  %c %{max([line('.'),1])}/%L %P"
                end,
                hl = { fg = colors.string, bg = bg },
            }
        end

        -- GIT
        local git_branch_cache = {}

        local function get_git_branch()
            local cwd = vim.fn.getcwd()
            if git_branch_cache[cwd] ~= nil then
                return git_branch_cache[cwd]
            end
            local result = vim.fn.systemlist("git -C " ..
                vim.fn.shellescape(cwd) .. " rev-parse --abbrev-ref HEAD 2>/dev/null")
            local branch = (result and result[1] and result[1] ~= "" and vim.v.shell_error == 0) and result[1] or false
            git_branch_cache[cwd] = branch
            return branch
        end

        vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "DirChanged" }, {
            callback = function()
                git_branch_cache = {}
                vim.cmd("redrawstatus")
            end,
        })

        local function git(bg)
            return {
                hl = { fg = colors.macro, bg = bg },

                { -- git branch name
                    provider = function()
                        local branch = get_git_branch()
                        if not branch then
                            return " " .. null
                        elseif branch == "HEAD" then
                            return " [detached]"
                        end
                        return " " .. branch
                    end,
                },
            }
        end

        -- LSP / Lint
        local function lsp_lint(bg)
            return {
                -- condition = conditions.lsp_attached,
                update = { "LspAttach", "LspDetach", "BufEnter", "BufWritePost", "DiagnosticChanged" },
                static = {
                    error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1] and vim.fn.sign_getdefined(
                        "DiagnosticSignError"
                    )[1].text or "E",
                    warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1] and vim.fn.sign_getdefined(
                        "DiagnosticSignWarn"
                    )[1].text or "W",
                    info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1] and vim.fn.sign_getdefined(
                        "DiagnosticSignInfo"
                    )[1].text or "I",
                    hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1] and vim.fn.sign_getdefined(
                        "DiagnosticSignHint"
                    )[1].text or "H",
                },
                init = function(self)
                    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
                    self.hint = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
                    self.warn = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
                    self.error = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
                end,
                provider = function()
                    local result = "  "

                    if not conditions.lsp_attached then
                        return result .. null
                    end

                    -- LSP
                    local current_buf = vim.api.nvim_get_current_buf()
                    local lsp_clients = vim.lsp.get_clients()
                    local lsp_client_names = {}
                    local separator = ", "

                    for _, client in ipairs(lsp_clients) do
                        if vim.lsp.buf_is_attached(current_buf, client.id) then
                            if client.name ~= "copilot" then
                                table.insert(lsp_client_names, client.name)
                            end
                        end
                    end

                    -- Lint
                    local ft = vim.bo[current_buf].filetype
                    local linters_by_ft = require("lint").linters_by_ft[ft] or {}
                    local linter_clients = {}

                    for _, name in ipairs(linters_by_ft) do
                        table.insert(linter_clients, name)
                    end
                    local linter_names = table.concat(linter_clients, separator)

                    -- Combine
                    if #lsp_client_names > 0 or #linters_by_ft > 0 then
                        if #lsp_client_names > 0 then
                            result = result .. table.concat(lsp_client_names, separator)
                        end
                        if #linters_by_ft > 0 then
                            if #lsp_client_names > 0 then
                                result = result .. separator
                            end
                            result = result .. linter_names
                        end
                        result = result
                        return result
                    else
                        return result .. null
                    end
                end,
                {
                    provider = function(self)
                        return self.info > 0 and (" " .. self.info_icon .. self.info)
                    end,
                    hl = { fg = colors.method, bg = bg },
                },
                {
                    provider = function(self)
                        return self.hint > 0 and (" " .. self.hint_icon .. self.hint) or ""
                    end,
                    hl = { fg = colors.macro, bg = bg },
                },
                {
                    provider = function(self)
                        return self.warn > 0 and (" " .. self.warn_icon .. self.warn) or ""
                    end,
                    hl = { fg = colors.namespace, bg = bg },
                },
                {
                    provider = function(self)
                        return self.error > 0 and (" " .. self.error_icon .. self.error) or ""
                    end,
                    hl = { fg = colors.error, bg = bg },
                },
                hl = { fg = colors.number, bg = bg },
            }
        end

        -- WORKING DIRECTORY
        local function work_dir(bg)
            return {
                provider = function()
                    local icon = "  "
                    local cwd = vim.fn.getcwd(0)
                    cwd = vim.fn.fnamemodify(cwd, ":~")
                    if not conditions.width_percent_below(#cwd, 0.25) then
                        cwd = vim.fn.fnamemodify(cwd, ":t")
                    end
                    return icon .. cwd
                end,
                hl = { fg = colors.struct, bg = bg },
            }
        end

        -- DEBUG
        local function debug(bg)
            return {
                condition = function()
                    return require("dap").session() ~= nil
                end,
                provider = function()
                    return "  " .. require("dap").status()
                end,
                hl = { fg = colors.keyword, bg = bg },
            }
        end

        -- DATE TIME
        local function date_time(bg)
            return {
                provider = function()
                    -- return os.date("%Y-%m-%d %I:%M:%S %p")
                    return os.date("%I:%M %p")
                end,
                hl = { fg = colors.struct, bg = bg, bold = true },
            }
        end

        local function startTimerOnSecondDivisibleBy(updateRateInSeconds)
            local currentTime = os.date("*t")
            local currentSecond = currentTime.sec
            local millisecondsTillNextDivisibleSecond = (
                (updateRateInSeconds - (currentSecond % updateRateInSeconds)) % updateRateInSeconds
            ) * 1000
            if millisecondsTillNextDivisibleSecond == 0 then
                millisecondsTillNextDivisibleSecond = updateRateInSeconds * 1000
            end
            vim.fn.timer_start(millisecondsTillNextDivisibleSecond, function()
                vim.cmd("redrawstatus")
            end, { ["repeat"] = -1 })
        end
        startTimerOnSecondDivisibleBy(60)

        -- GRAPPLE
        local grapple = {
            provider = function()
                local value = require("grapple").name_or_index()
                if value == "" then
                    return nil
                end
                return " " .. "[" .. value .. "]"
            end,
            condition = function()
                return require("grapple").exists()
            end,
            hl = { fg = colors.struct, bg = colors.none },
        }

        -- MEMES
        local meme = {
            provider = " [Penger Pics: 3.6TB]",
            hl = { fg = colors.error, bg = colors.none },
        }

        -- Auto-Session
        -- local auto_session = {
        -- 	provider = require("auto-session.lib").current_session_name,
        -- 	hl = { fg = colors.error, bg = colors.none },
        -- }

        -- Layout Logic
        local function slant(direction, primary, secondary)
            return {
                direction == "left" and {
                    provider = " ",
                    hl = { fg = secondary, bg = primary },
                },
                {
                    -- provider = direction == "right" and "" or "",
                    provider = direction == "right" and "" or "",
                    -- provider = direction == "right" and "" or "",
                    -- provider = direction == "right" and "" or "",
                    hl = { fg = primary, bg = secondary },
                },
                direction == "right" and {
                    provider = " ",
                    hl = { fg = secondary, bg = primary },
                },
            }
        end

        local function section(direction, primary, secondary, contents)
            local result = {}

            if direction == "right" then
                table.insert(result, slant(direction, primary, secondary))
            else
                table.insert(result, spacer(primary))
            end

            for i, content_func in ipairs(contents) do
                table.insert(result, content_func(primary))
                if i < #contents then
                    table.insert(result, spacer(primary))
                end
            end

            if direction == "left" then
                table.insert(result, slant(direction, primary, secondary))
            else
                table.insert(result, spacer(primary))
            end

            return result
        end

        local function dynamic_section(direction, primary, contents, next_or_prev_primary)
            local secondary = next_or_prev_primary or colors.none
            return section(direction, primary, secondary, contents)
        end

        local function get_next_or_prev_primary(sections, index, direction, align_index)
            if direction == "right" then
                -- If the transition is immediately after align, use colors.none
                if index == align_index + 1 then
                    return colors.none
                end
                for i = index - 1, 1, -1 do
                    local sec = sections[i]
                    if type(sec) == "table" and sec.primary then
                        return sec.primary
                    end
                end
            else
                -- If transitioning right before align, use colors.none
                if index == align_index - 1 then
                    return colors.none
                end
                for i = index + 1, #sections do
                    local sec = sections[i]
                    if type(sec) == "table" and sec.primary then
                        return sec.primary
                    end
                end
            end
            return colors.none
        end

        local function determine_direction(index, align_index)
            if align_index then
                return index < align_index and "left" or "right"
            end
            return "left"
        end

        local sections = {
            { primary = colors.window_accent, contents = { vim_mode } },
            { primary = colors.window_bg,     contents = { work_dir } },
            { primary = colors.window_accent, contents = { git } },
            { primary = colors.window_bg,     contents = { file_size } },
            { primary = colors.window_accent, contents = { file_format } },
            { primary = colors.window_bg,     contents = { file_encoding } },
            { primary = colors.window_accent, contents = { file_type } },
            { primary = colors.window_bg,     contents = { lsp_lint } },
            align_cut,
            { primary = colors.window_bg,     contents = { ruler } },
            { primary = colors.window_accent, contents = { date_time } },
        }

        local align_index
        for i, sec in ipairs(sections) do
            if sec == align_cut then
                align_index = i
                break
            end
        end

        local statusline = {}
        for i, sec in ipairs(sections) do
            if type(sec) == "table" and sec.contents then
                local direction = determine_direction(i, align_index)
                local next_or_prev_primary = get_next_or_prev_primary(sections, i, direction, align_index)
                table.insert(statusline, dynamic_section(direction, sec.primary, sec.contents, next_or_prev_primary))
            else
                table.insert(statusline, sec)
            end
        end

        -- Init
        require("heirline").setup({
            statusline = statusline,
            winbar = nil,
        })
    end,
}

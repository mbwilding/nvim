return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        --"nvim-tree/nvim-web-devicons",
    },
    config = function()
        local lualine = require("lualine")
        local colors = require("config/colors").base
        local mode_color = require("config/colors-mode")

        local conditions = {
            buffer_not_empty = function()
                return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
            end,
            hide_in_width = function()
                return vim.fn.winwidth(0) > 80
            end,
            check_git_workspace = function()
                local filepath = vim.fn.expand('%:p:h')
                local gitdir = vim.fn.finddir('.git', filepath .. ';')
                return gitdir and #gitdir > 0 and #gitdir < #filepath
            end,
        }

        -- Don't modify
        local config = {
            options = {
                component_separators = '',
                section_separators = '',
                globalstatus = true,
                icons_enabled = true,
                theme = {
                    normal = { c = { fg = colors.orange, bg = colors.transparent } },
                    inactive = { c = { fg = colors.gray, bg = colors.transparent } },
                },
            },
            sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                lualine_c = {},
                lualine_x = {},
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                lualine_c = {},
                lualine_x = {},
            },
        }

        local function ins_left(component)
            table.insert(config.sections.lualine_c, component)
        end

        local function ins_right(component)
            table.insert(config.sections.lualine_x, component)
        end

        ins_left {
            'location',
            color = function()
                return { fg = mode_color[vim.fn.mode()], gui = "bold" }
            end,
            padding = { left = 3, right = 1 }
        }

        ins_left {
            'progress',
            fmt = string.upper,
            color = function()
                return { fg = mode_color[vim.fn.mode()], gui = "bold" }
            end,
        }






        ins_left {
            function()
                return '%='
            end,
        }

        ins_left {
            'filename',
            cond = conditions.buffer_not_empty,
            fmt = function(s)
                return "FILE: " .. s:upper()
            end,
            color = function()
                return { fg = mode_color[vim.fn.mode()], gui = "bold" }
            end,
        }

        ins_left {
            'filesize',
            cond = conditions.buffer_not_empty,
            fmt = function(s)
                return "SIZE: " .. s:upper()
            end,
            color = function()
                return { fg = mode_color[vim.fn.mode()], gui = "bold" }
            end,
        }

        --ins_left {
        --    'filetype',
        --    icons_enabled = false,
        --    cond = conditions.buffer_not_empty,
        --    fmt = string.upper,
        --    color = function()
        --        return { fg = mode_color[vim.fn.mode()], gui = "bold" }
        --    end,
        --}

        ins_left {
            'o:encoding',
            cond = conditions.buffer_not_empty,
            fmt = function(s)
                return "ENC: " .. s:upper()
            end,
            color = function()
                return { fg = mode_color[vim.fn.mode()], gui = "bold" }
            end,
        }

        ins_left {
            'fileformat',
            cond = conditions.buffer_not_empty,
            icons_enabled = false,
            fmt = function(s)
                return "LE: " .. s:upper()
            end,
            color = function()
                return { fg = mode_color[vim.fn.mode()], gui = "bold" }
            end,
        }

        ins_left {
            'selectioncount',
            cond = conditions.buffer_not_empty,
            fmt = function(s)
                if s ~= "" then
                    return "SEL: " .. s:upper()
                end
            end,
            color = function()
                return { fg = mode_color[vim.fn.mode()], gui = "bold" }
            end,
        }






        ins_right {
            function()
                return '%='
            end,
        }

        ins_right {
            -- LSP
            function()
                local no_lsp_msg = 'NULL'
                local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                local clients = vim.lsp.get_clients()
                if next(clients) == nil then
                    return no_lsp_msg
                end
                for _, client in ipairs(clients) do
                    local filetypes = client.config.filetypes
                    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                        return client.name
                    end
                end
                return no_lsp_msg
            end,
            --icon = '',
            cond = conditions.buffer_not_empty,
            fmt = function(s)
                return "LSP: " .. s:upper()
            end,
            color = function()
                return { fg = mode_color[vim.fn.mode()], gui = "bold" }
            end,
        }

        ins_right {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            icons_enabled = false,
            --symbols = { error = ' ', warn = ' ', info = ' ' },
            diagnostics_color = {
                color_error = { fg = colors.error },
                color_warn = { fg = colors.orange },
                color_info = { fg = colors.green },
            },
            fmt = function(s)
                if s ~= "" then
                    return "DIAG: " .. s:upper()
                end
            end,
        }






        ins_right {
            function()
                return '%='
            end,
        }

        ins_right {
            'branch',
            --icon = '',
            icon = '',
            fmt = function(s)
                return "GIT: " .. s:upper()
            end,
            cond = conditions.buffer_not_empty,
            color = function()
                return { fg = mode_color[vim.fn.mode()], gui = "bold" }
            end,
        }

        ins_right {
            'diff',
            -- Is it me or the symbol for modified us really weird
            --symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
            icons_enabled = false,
            diff_color = {
                added = { fg = colors.green },
                modified = { fg = colors.blue_light },
                removed = { fg = colors.red },
            },
            cond = conditions.hide_in_width,
            fmt = function(s)
                if s ~= "" then
                    return "DIFF: " .. s:upper()
                end
            end
        }

        lualine.setup(config)
    end
}

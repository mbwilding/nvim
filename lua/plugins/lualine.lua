return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local lualine = require("lualine")
        local colors = require("config/colors")

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

        -- Config
        local config = {
            options = {
                -- Disable sections and component separators
                component_separators = '',
                section_separators = '',
                globalstatus = true,
                icons_enabled = true,
                theme = {
                    -- We are going to use lualine_c an lualine_x as left and
                    -- right section. Both are highlighted by c theme .  So we
                    -- are just setting default looks o statusline
                    normal = { c = { fg = colors.fg, bg = colors.bg } },
                    inactive = { c = { fg = colors.fg, bg = colors.bg } },
                },
            },
            sections = {
                -- these are to remove the defaults
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                -- These will be filled later
                lualine_c = {},
                lualine_x = {},
            },
            inactive_sections = {
                -- these are to remove the defaults
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                lualine_c = {},
                lualine_x = {},
            },
        }

        -- Inserts a component in lualine_c at left section
        local function ins_left(component)
            table.insert(config.sections.lualine_c, component)
        end

        -- Inserts a component in lualine_x at right section
        local function ins_right(component)
            table.insert(config.sections.lualine_x, component)
        end

        ins_left {
            -- mode component
            function()
                return ' '
            end,
            color = function()
                local mode_color = {
                    n = colors.blue,
                    i = colors.green,
                    v = colors.purple,
                    [''] = colors.keyword,
                    V = colors.keyword,
                    c = colors.attribute,
                    no = colors.macro,
                    s = colors.orange,
                    S = colors.orange,
                    [''] = colors.orange,
                    ic = colors.member,
                    R = colors.number,
                    Rv = colors.number,
                    cv = colors.macro,
                    ce = colors.macro,
                    r = colors.todo,
                    rm = colors.todo,
                    ['r?'] = colors.todo,
                    ['!'] = colors.macro,
                    t = colors.macro,
                }
                return { fg = mode_color[vim.fn.mode()] }
            end,
            --padding = { right = 0 },
        }

        ins_left {
            'filename',
            cond = conditions.buffer_not_empty,
            color = { fg = colors.fg, gui = 'bold' },
        }

        ins_left {
            'filetype',
            cond = conditions.buffer_not_empty,
            color = { fg = colors.fg, gui = 'bold' },
        }

        ins_left {
            'filesize',
            cond = conditions.buffer_not_empty,
            color = { fg = colors.fg, gui = 'bold' },
        }

        ins_left { 'location' }

        ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

        ins_left { 'selectioncount' }

        -- Insert mid section. You can make any number of sections in neovim :)
        -- for lualine it's any number greater then 2

        --ins_left {
        --    function()
        --        return '%='
        --    end,
        --}

        -- Add components to right sections
        ins_right {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            symbols = { error = ' ', warn = ' ', info = ' ' },
            diagnostics_color = {
                color_error = { fg = colors.error },
                color_warn = { fg = colors.orange },
                color_info = { fg = colors.blue_light },
            },
        }

        ins_right {
            -- LSP
            function()
                local no_lsp_msg = ''
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
            icon = '',
            color = { fg = colors.blue, gui = 'bold' },
        }

        ins_right {
            'o:encoding',
            fmt = string.upper,
            cond = conditions.hide_in_width,
            color = { fg = colors.green, gui = 'bold' },
        }

        ins_right {
            'fileformat',
            fmt = string.upper,
            icons_enabled = false,
            color = { fg = colors.orange, gui = 'bold' },
        }

        ins_right {
            'diff',
            -- Is it me or the symbol for modified us really weird
            symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
            diff_color = {
                added = { fg = colors.green },
                modified = { fg = colors.blue_light },
                removed = { fg = colors.error },
            },
            cond = conditions.hide_in_width,
        }

        ins_right {
            'branch',
            icon = '',
            color = { fg = colors.purple, gui = 'bold' },
        }

        lualine.setup(config)
    end
}

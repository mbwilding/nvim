return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "arkav/lualine-lsp-progress"
    },
    config = function()
        local lualine = require("lualine")

        local function get_lsp_name()
            local msg = "LS Inactive"
            local buf_clients = vim.lsp.get_active_clients()
            -- local buf_clients = vim.lsp.buf_get_clients()
            if next(buf_clients) == nil then
                if type(msg) == "boolean" or #msg == 0 then
                    return "LS Inactive"
                end
            end
            -- end
            local buf_client_names = {}
            local copilot_active = false
            for _, client in pairs(buf_clients) do
                table.insert(buf_client_names, client.name)
                if client.name == "copilot" then
                    copilot_active = true
                end
            end
            local unique_client_names = vim.fn.uniq(buf_client_names)
            local language_servers = "[" .. table.concat(unique_client_names, ", ") .. "]"
            -- return language_servers;
            -- end
            -- if copilot_active then
            -- 	language_servers = language_servers .. "#SLCopilot#" .. "" --.. "%*"
            -- end
            --
            return language_servers
        end

        lualine.setup {
            options = {
                icons_enabled = true,
                theme = "auto",
                component_separators = "|",
                section_separators = {left = "", right = ""},
                globalstatus = true,
            },
            sections = {
                lualine_b = {
                    "branch",
                    "diff",
                    "filename",
                    "filesize",
                    "diagnostics"
                },
                lualine_c = {
                    --"lsp_progress"
                },
                lualine_x = {
                    {get_lsp_name},
                    "encoding",
                    "fileformat",
                    "filetype",
                    "selectioncount"
                }
            }
        }
    end
}

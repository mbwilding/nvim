-- local function hello()
--     return [[hello world]]
-- end

local function working_dir()
    local icon = " "
    local cwd = vim.fn.getcwd(0)
    cwd = vim.fn.fnamemodify(cwd, ":~")
    return icon .. " " .. cwd
end

local function lsp_lint()
    -- LSP
    local current_buf = vim.api.nvim_get_current_buf()
    local lsp_clients = vim.lsp.get_clients()
    local lsp_client_names = {}
    local separator = ", "

    for _, client in ipairs(lsp_clients) do
        if vim.lsp.buf_is_attached(current_buf, client.id) then
            table.insert(lsp_client_names, client.name)
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
        local result = "  "
        if #lsp_client_names > 0 then
            result = result .. table.concat(lsp_client_names, separator)
        end
        if #linters_by_ft > 0 then
            if #lsp_client_names > 0 then
                result = result .. separator
            end
            result = result .. linter_names
        end
        return result
    else
        return ""
    end
end

return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        -- options = {
        --     theme = "tokyonight",
        -- },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = { working_dir }, -- filename
            lualine_x = { "encoding", "fileformat" }, -- "filetype"
            lualine_y = { lsp_lint, "progress" },
            lualine_z = { "location" },
        },
    },
}

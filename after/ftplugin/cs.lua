-- Decompilation clean-up
if vim.api.nvim_buf_get_name(0):find("/tmp/MetadataAsSource/") then
    local match = "#if false // Decompilation log"
    local bufnr = 0
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local cleaned_len = 0
    for i, line in ipairs(lines) do
        if vim.startswith(line, match) then
            break
        end
        cleaned_len = i
    end
    if cleaned_len == 0 then
        return
    end

    vim.api.nvim_buf_set_lines(bufnr, cleaned_len, -1, false, {})
end

local function clean_decompiled_cs(lines)
    local decomp_start, decomp_end

    for i = #lines, 1, -1 do
        if not decomp_end and lines[i]:match("^#endif") then
            decomp_end = i
        elseif not decomp_start and lines[i]:match("^#if false.*Decompilation log") then
            decomp_start = i
            break
        end
    end

    if decomp_start and decomp_end and decomp_start <= decomp_end then
        if table.move then
            table.move(lines, decomp_end + 1, #lines, decomp_start, lines)
            for i = #lines, #lines - (decomp_end - decomp_start), -1 do
                lines[i] = nil
            end
        else
            for i = decomp_end, decomp_start, -1 do
                table.remove(lines, i)
            end
        end
    end

    return lines
end

if vim.api.nvim_buf_get_name(0):find("/tmp/MetadataAsSource/") then
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local cleaned = clean_decompiled_cs(lines)

    if cleaned ~= lines then
        vim.api.nvim_buf_set_lines(0, 0, -1, false, cleaned)
    end
end

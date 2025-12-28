return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    config = function()
        -- Collect all available parsers
        local queries_dir = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/runtime/queries"
        local file_types = {}
        for name, type in vim.fs.dir(queries_dir) do
            if type == "directory" then
                table.insert(file_types, name)
            end
        end

        -- Install file type parsers
        require("nvim-treesitter").install(file_types)

        -- Additional file types
        local file_types_extra = {
            "cs"
        }

        for _, file_type in ipairs(file_types_extra) do
            table.insert(file_types, file_type)
        end

        -- Automatically activate
        vim.api.nvim_create_autocmd("FileType", {
            pattern = file_types,
            callback = function()
                -- Highlights
                vim.treesitter.start()
                -- Folds
                vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
                vim.wo[0][0].foldmethod = "expr"
                -- Indentation
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}

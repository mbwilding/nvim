return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        {
            "nvim-treesitter/nvim-treesitter-textobjects",
            branch = "main",
        },
    },
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

        -- Install languages
        require("nvim-treesitter").install(file_types)

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

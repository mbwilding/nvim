return {
    -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            -- Build command adjusted to use 'make' if available, otherwise 'cmake'
            build = function()
                if vim.fn.executable('make') == 1 then
                    return 'make'
                elseif vim.fn.executable('cmake') == 1 then
                    return 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
                else
                    error("Neither 'make' nor 'cmake' are available for building telescope-fzf-native.nvim")
                end
            end,
            -- This plugin is conditionally loaded if either 'make' or 'cmake' is available
            cond = function()
                return vim.fn.executable('make') == 1 or vim.fn.executable('cmake') == 1
            end,
        },
    },
}

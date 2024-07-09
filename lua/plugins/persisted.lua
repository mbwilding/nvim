return {
    "olimorris/persisted.nvim",
    lazy = false,
    config = function()
        require("persisted").setup({
            use_git_branch = false,     -- create session files based on the branch of a git enabled repository
            autosave = false,           -- automatically save session files when exiting Neovim
            autoload = true,            -- automatically load the session for the cwd on Neovim startup
            silent = true,              -- No message on loading a session
            ignored_branches = { "~" }, -- table of branch patterns that are ignored for auto-saving and auto-loading
            should_autosave = function()
                return vim.bo.filetype ~= "alpha"
            end, -- function to determine if a session should be autosaved
        })
        vim.keymap.set("n", "<leader>tp", "<CMD>Telescope persisted<CR>")
    end,
}

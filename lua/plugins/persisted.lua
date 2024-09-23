-- Persisted is a session manager

local man = vim.tbl_contains(vim.v.argv, "+Man!")

return {
    "olimorris/persisted.nvim",
    lazy = false,
    keys = {
        {
            "<leader>tp",
            "<CMD>Telescope persisted<CR>",
            desc = "Persisted: Telescope",
        },
    },
    opts = {
        use_git_branch = false, -- create session files based on the branch of a git enabled repository
        autosave = false,        -- automatically save session files when exiting Neovim
        autoload = not man,     -- automatically load the session for the cwd on Neovim startup
        silent = true,          -- No message on loading a session
        follow_cwd = true,      -- follow the cwd of the session file
        should_autosave = function()
            return vim.bo.filetype ~= "alpha"
            and vim.fn.getcwd() ~= os.getenv("HOME")
            and not man
        end,
    }
}

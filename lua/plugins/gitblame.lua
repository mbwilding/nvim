return {
    "f-person/git-blame.nvim",
    config = function()
        vim.g.gitblame_enabled = false
        vim.g.gitblame_delay = 0

        vim.api.nvim_set_keymap('n', '<leader>gbb', '<cmd>GitBlameToggle<CR>', { noremap = true, silent = true })

        -- Lua function to set gitblame delay
        local function set_gitblame_delay(delay)
            vim.g.gitblame_delay = delay
        end

        -- Create a command that prompts for delay value
        vim.api.nvim_create_user_command(
            'SetGitBlameDelay',
            function(input)
                local delay = tonumber(input.args)
                if delay then
                    set_gitblame_delay(delay)
                else
                    print("Invalid delay value")
                end
            end,
            { nargs = 1 }
        )

        -- Key binding to invoke the command
        vim.api.nvim_set_keymap('n', '<leader>gbd', ':SetGitBlameDelay ', { noremap = true, silent = false })
    end
}

-- Add/delete/replace surroundings (brackets, quotes, etc.)

-- Examples:
--  - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
--  - sd'   - [S]urround [D]elete [']quotes
--  - sr)'  - [S]urround [R]eplace [)] [']

return {
    "echasnovski/mini.surround",
    lazy = true,
    event = "BufEnter",
    opts = {},
}

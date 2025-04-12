-- Better Around/Inside textobjects

-- Examples:
--  - va)  - [V]isually select [A]round [)]paren
--  - yinq - [Y]ank [I]nside [N]ext [']quote
--  - ci'  - [C]hange [I]nside [']quote

return {
    "echasnovski/mini.ai",
    lazy = true,
    event = "BufEnter",
    opts = {
        n_lines = 500,
    },
}

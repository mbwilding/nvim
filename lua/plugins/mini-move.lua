return {
    "nvim-mini/mini.move",
    branch = "main",
    lazy = true,
    event = "BufEnter",
    opts = {
        mappings = {
            -- Normal
            line_left = "<M-h>",
            line_right = "<M-l>",
            line_down = "<M-j>",
            line_up = "<M-k>",
            -- Visual
            left = "<M-h>",
            right = "<M-l>",
            down = "<M-j>",
            up = "<M-k>",
        },
        options = {
            reindent_linewise = true,
        },
    },
}

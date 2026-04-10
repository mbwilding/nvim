return {
    "A7Lavinraj/fyler.nvim",
    dependencies = {
        -- "nvim-mini/mini.icons"
        "nvim-tree/nvim-web-devicons",
    },
    branch = "main", -- stable
    lazy = false,
    enabled = true,
    dev = false,
    keys = {
        {
            "-",
            function()
                require("fyler").open()
            end,
            desc = "Fyler",
        },
    },
    opts = {
        integrations = {
            icon = "nvim_web_devicons",
        },
        hooks = {
            on_rename = function(src_path, destination_path)
                Snacks.rename.on_rename_file(src_path, destination_path)
            end,
        },
        views = {
            finder = {
                close_on_select = true,
                confirm_simple = false,
                default_explorer = true,
                delete_to_trash = false,
                git_status = {
                    enabled = true,
                    symbols = {
                        Untracked = "?",
                        Added = "+",
                        Modified = "~",
                        Deleted = "x",
                        Renamed = ">",
                        Copied = "c",
                        Conflict = "#",
                        Ignored = "!",
                    },
                },
                icon = {
                    directory_collapsed = nil,
                    directory_empty = nil,
                    directory_expanded = nil,
                },
                indentscope = {
                    enabled = true,
                    group = "FylerIndentMarker",
                    marker = "│",
                },
                mappings = {
                    ["q"] = "CloseView",
                    ["<CR>"] = "Select",
                    ["<C-t>"] = "SelectTab",
                    ["<C-v>"] = "SelectVSplit",
                    ["<C-s>"] = "SelectSplit",
                    ["-"] = "GotoParent",
                    ["="] = "GotoCwd",
                    ["."] = "GotoNode",
                    ["#"] = "CollapseAll",
                    ["<BS>"] = "CollapseNode",
                },
                mappings_opts = {
                    nowait = false,
                    noremap = true,
                    silent = true,
                },
                follow_current_file = true,
                watcher = {
                    enabled = false,
                },
                win = {
                    border = vim.o.winborder == "" and "single" or vim.o.winborder,
                    buf_opts = {
                        filetype = "fyler",
                        syntax = "fyler",
                        buflisted = false,
                        buftype = "acwrite",
                        expandtab = true,
                        shiftwidth = 2,
                    },
                    kind = "replace",
                    kinds = {
                        float = {
                            height = "70%",
                            width = "70%",
                            top = "10%",
                            left = "15%",
                        },
                        replace = {},
                        split_above = {
                            height = "70%",
                        },
                        split_above_all = {
                            height = "70%",
                            win_opts = {
                                winfixheight = true,
                            },
                        },
                        split_below = {
                            height = "70%",
                        },
                        split_below_all = {
                            height = "70%",
                            win_opts = {
                                winfixheight = true,
                            },
                        },
                        split_left = {
                            width = "30%",
                        },
                        split_left_most = {
                            width = "30%",
                            win_opts = {
                                winfixwidth = true,
                            },
                        },
                        split_right = {
                            width = "30%",
                        },
                        split_right_most = {
                            width = "30%",
                            win_opts = {
                                winfixwidth = true,
                            },
                        },
                    },
                    win_opts = {
                        concealcursor = "nvic",
                        conceallevel = 3,
                        cursorline = false,
                        number = false,
                        relativenumber = false,
                        winhighlight = "Normal:FylerNormal,NormalNC:FylerNormalNC",
                        wrap = false,
                        signcolumn = "no",
                    },
                },
            },
        },
    },
}
